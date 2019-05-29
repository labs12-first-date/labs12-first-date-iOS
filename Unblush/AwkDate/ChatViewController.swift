//
//  ChatViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/13/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import Photos
import Firebase
import MessageKit
import MessageInputBar
import FirebaseFirestore

class ChatViewController: MessagesViewController {

    private var isSendingPhoto = false {
        didSet {
            DispatchQueue.main.async {
                self.messageInputBar.leftStackViewItems.forEach { item in
                    //item.isEnabled = !self.isSendingPhoto
                }
            }
        }
    }
    
    private let db = Firestore.firestore()
    private var reference: CollectionReference?
    private var chattingUserReference: CollectionReference?
    private var chattingUserIdReference: DocumentReference?
    private var userFCMTokenReference: DocumentReference?
    private var chattingUserFCMTokenReference: DocumentReference?
    private let storage = Storage.storage().reference()
    
    var messages: [Message] = []
    private var messageListener: ListenerRegistration?
    var chattingUserFCMToken: String?
    
    let user: User
    let messageThread: MessageThread
    let chattingUserUID: String
    
    deinit {
        messageListener?.remove()
    }
    
    init(user: User, messageThread: MessageThread, chattingUserUID: String) {
        self.user = user
        self.messageThread = messageThread
        self.chattingUserUID = chattingUserUID
        super.init(nibName: nil, bundle: nil)
        
        title = messageThread.name
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id = messageThread.id else {
            //navigationController?.popViewController(animated: true)
            print("no message thread id")
            return
        }
        
        // /messageThreadsiOS/HQccWvMsSHNxYb8RnYvvnJqndq92/threads/6XAgoEq1J8mRDa1AAIqf
    
        reference = db.collection(["messageThreadsiOS", user.uid, "threads", id, "messages"].joined(separator: "/"))
        chattingUserReference = db.collection(["messageThreadsiOS", chattingUserUID, "threads", id, "messages"].joined(separator: "/"))
        chattingUserIdReference = db.document(["messageThreadsiOS", chattingUserUID, "threads", id].joined(separator: "/"))
        userFCMTokenReference = db.document(["users_table", user.uid].joined(separator: "/"))
        chattingUserFCMTokenReference = db.document(["users_table", chattingUserUID].joined(separator: "/"))
        
        messageListener = reference?.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for message thread updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
        reference?.getDocuments(completion: { (querySnapshot, error) in
            if let error = error {
                print("Error fetching messages from id: \(error)")
                return
            }
            
            guard let querySnap = querySnapshot else {
                print("No query snapshot")
                return
            }
            
            for document in querySnap.documents {
                print("Document msg: \(document)")
                let msg = Message(document: document)!
                guard !self.messages.contains(msg) else {
                    return
                }
                self.messages.append(msg)
            }
        })
        
        chattingUserFCMTokenReference?.getDocument(completion: { (querySnapshot, error) in
            if let error = error {
                print("Error fetching messages from id: \(error)")
                return
            }
            guard let querySnap = querySnapshot else {
                print("No query snapshot")
                return
            }
            
            let data = querySnap.data()
            self.chattingUserFCMToken = data!["fcmToken"] as! String
            
        })
        
        navigationItem.largeTitleDisplayMode = .never
        
        maintainPositionOnKeyboardFrameChanged = true
        messageInputBar.inputTextView.tintColor = .primary
        messageInputBar.sendButton.setTitleColor(.primary, for: .normal)
        
        messageInputBar.delegate = self
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        let cameraItem = InputBarButtonItem(type: .system) // 1
        cameraItem.tintColor = .primary
        cameraItem.image = UIImage(named: "Image-1")
        cameraItem.addTarget(
            self,
            action: #selector(cameraButtonPressed), // 2
            for: .primaryActionTriggered
        )
        cameraItem.setSize(CGSize(width: 60, height: 30), animated: false)
        
        messageInputBar.leftStackView.alignment = .center
        messageInputBar.setLeftStackViewWidthConstant(to: 50, animated: false)
        messageInputBar.setStackViewItems([cameraItem], forStack: .left, animated: false) // 3
    }
    
    
    // MARK: - Actions
    
    @objc private func cameraButtonPressed() {
        let picker = UIImagePickerController()
        picker.delegate = self
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    // MARK: - Helpers
    
    private func save(_ message: Message) {
        chattingUserIdReference?.setData(["name": AppSettings.displayName!, "chatting_with": user.uid], merge: true, completion: { (error) in
            if let error = error {
                print("Error naming message thread: \(error)")
                return
            }
            self.chattingUserReference?.addDocument(data: message.representation)
        })
        
        
        reference?.addDocument(data: message.representation) { error in
            if let e = error {
                print("Error sending message: \(e.localizedDescription)")
                return
            }
            
            self.messagesCollectionView.scrollToBottom()
            
            let sender = PushNotificationSender()
            sender.sendPushNotification(to: self.chattingUserFCMToken!, title: "New Message", body: "Reply to \(AppSettings.displayName!)")
        }
    }
    
    private func insertNewMessage(_ message: Message) {
        guard !messages.contains(message) else {
            return
        }
        
        messages.append(message)
        messages.sort()
        
        let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
        let shouldScrollToBottom = messagesCollectionView.isAtBottom && isLatestMessage
        
        DispatchQueue.main.async {
            self.messagesCollectionView.reloadData()
        }
        
        
        if shouldScrollToBottom {
            DispatchQueue.main.async {
                self.messagesCollectionView.scrollToBottom(animated: true)
            }
        }
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        guard var message = Message(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            if let url = message.downloadURL {
                downloadImage(at: url) { [weak self] image in
                    guard let `self` = self else {
                        return
                    }
                    guard let image = image else {
                        return
                    }
                    
                    message.image = image as! MediaItem
                    self.insertNewMessage(message)
                }
            } else {
                insertNewMessage(message)
            }
            
        default:
            break
        }
    }
    
    private func uploadImage(_ image: UIImage, to messageThread: MessageThread, completion: @escaping (URL?) -> Void) {
        guard let messageThreadID = messageThread.id else {
            completion(nil)
            return
        }
        
        guard let scaledImage = image.scaledToSafeUploadSize, let data = scaledImage.jpegData(compressionQuality: 0.4) else {
            completion(nil)
            return
        }
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let imageName = [UUID().uuidString, String(Date().timeIntervalSince1970)].joined()
        storage.child(messageThreadID).child(imageName).putData(data, metadata: metadata) { meta, error in
            self.storage.child(messageThreadID).child(imageName).downloadURL(completion: { (url, error) in
                if let error = error {
                    print("Error storing image from messages: \(error)")
                    return
                }
                completion(url)
            })
        }
    }
    
    private func sendPhoto(_ image: UIImage) {
        isSendingPhoto = true
        
        uploadImage(image, to: messageThread) { [weak self] url in
            guard let `self` = self else {
                return
            }
            self.isSendingPhoto = false
            
            guard let url = url else {
                return
            }
            
            var message = Message(user: self.user, image: image as! MediaItem)
            message.downloadURL = url
            
            self.save(message)
            self.messagesCollectionView.scrollToBottom()
        }
    }
    
    private func downloadImage(at url: URL, completion: @escaping (UIImage?) -> Void) {
        let ref = Storage.storage().reference(forURL: url.absoluteString)
        let megaByte = Int64(1 * 1024 * 1024)
        
        ref.getData(maxSize: megaByte) { data, error in
            guard let imageData = data else {
                completion(nil)
                return
            }
            
            completion(UIImage(data: imageData))
        }
    }
    
}

// MARK: - MessagesDisplayDelegate

extension ChatViewController: MessagesDisplayDelegate {
    
    func backgroundColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        return isFromCurrentSender(message: message) ? .primary : .incomingMessage
    }
    
    func shouldDisplayHeader(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> Bool {
        return false
    }
    
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        let corner: MessageStyle.TailCorner = isFromCurrentSender(message: message) ? .bottomRight : .bottomLeft
        return .bubbleTail(corner, .curved)
    }
    
}

// MARK: - MessagesLayoutDelegate

extension ChatViewController: MessagesLayoutDelegate {
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        let nameArray = Array(message.sender.displayName)
        avatarView.initials = String(nameArray.first!)
    }
    func avatarSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }
    
    func footerViewSize(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return CGSize(width: 0, height: 8)
    }
    
    func heightForLocation(message: MessageType, at indexPath: IndexPath, with maxWidth: CGFloat, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        
        return 0
    }
    

    
}

// MARK: - MessagesDataSource

extension ChatViewController: MessagesDataSource {
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return messages.count
    }
    
    // check user
    func currentSender() -> Sender {
        //print("current sender: \(AppSettings.displayName) \(user.uid)")
        return Sender(id: user.uid, displayName: AppSettings.displayName!)
    }
    
    func numberOfMessages(in messagesCollectionView: MessagesCollectionView) -> Int {
        print("Message count: \(messages.count)")
        return messages.count
    }
    
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        
        if messages.count == 0 {
            print("Messages are zero")
            return Message(user: self.user, content: "Let's Start Chatting!")
        } else {
           return messages[indexPath.section]
        }
        
    }

   
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 15
    }
  
    
    func cellBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment {
        return LabelAlignment(textAlignment: .natural, textInsets: .zero)
    }
    func messageBottomLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, h:mm a"
        let messageDate = dateFormatter.string(from: message.sentDate)
        
        return NSAttributedString(
            string: messageDate,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
    func cellTopLabelAttributedText(for message: MessageType, at indexPath: IndexPath) -> NSAttributedString? {
        print("message sender display name: \(message.sender.displayName)")
        let name = message.sender.displayName
        return NSAttributedString(
            string: name,
            attributes: [
                .font: UIFont.preferredFont(forTextStyle: .caption1),
                .foregroundColor: UIColor(white: 0.3, alpha: 1)
            ]
        )
    }
    
}

// MARK: - MessageInputBarDelegate

extension ChatViewController: MessageInputBarDelegate {
    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let message = Message(user: user, content: text)
        
       // insertNewMessage(message)
        save(message)
        inputBar.inputTextView.text = ""
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let asset = info[.phAsset] as? PHAsset { // 1
            let size = CGSize(width: 500, height: 500)
            PHImageManager.default().requestImage(for: asset, targetSize: size, contentMode: .aspectFit, options: nil) { result, info in
                guard let image = result else {
                    return
                }
                
                self.sendPhoto(image)
            }
        } else if let image = info[.originalImage] as? UIImage { // 2
            sendPhoto(image)
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
}

