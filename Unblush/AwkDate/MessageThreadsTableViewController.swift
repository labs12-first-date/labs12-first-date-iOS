//
//  MessageThreadsTableViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/13/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

class MessageThreadsTableViewController: UITableViewController {
    
    private let toolbarLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    
    private let messageThreadCellIdentifier = "MessageCell"
    private var currentChannelAlertController: UIAlertController?
    
    private let db = Firestore.firestore()
    
    private var messageThreads = [MessageThread]()
    private var messageThreadListener: ListenerRegistration?
    private var chattingUserMessageThreadListener: ListenerRegistration?
    
    
    var currentUser: User?
    var chattingUserUID: String?
    let userController = User2Controller()
    
   // ar ref: DocumentReference? = nil
  //  ref = self.db.collection("profilesiOS").document(userID)
    
    private var messageThreadReference: CollectionReference {
        return db.collection("messageThreadsiOS").document(currentUser!.uid).collection("threads")
    }
    
    private var chattingUserMessageThreadReference: CollectionReference {
        return db.collection("messageThreadsiOS").document(chattingUserUID!).collection("threads")
    }
    
    deinit {
        messageThreadListener?.remove()
    }
    
    init(currentUser: User) {
        self.currentUser = currentUser
        super.init(style: .grouped)
        
        title = "Message Threads"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        clearsSelectionOnViewWillAppear = true
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: messageThreadCellIdentifier)
        
        toolbarItems = [
            UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(signOut)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(customView: toolbarLabel),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonPressed)),
        ]
        toolbarLabel.text = AppSettings.displayName
        
        messageThreadListener = messageThreadReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for message thread updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
        chattingUserMessageThreadListener = chattingUserMessageThreadReference.addSnapshotListener { querySnapshot, error in
            guard let snapshot = querySnapshot else {
                print("Error listening for message thread updates: \(error?.localizedDescription ?? "No error")")
                return
            }
            
            snapshot.documentChanges.forEach { change in
                self.handleDocumentChange(change)
            }
        }
        
        messageThreadReference.getDocuments(completion: { (querySnapshot, error) in
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
                let thread = MessageThread(document: document)!
                guard !self.messageThreads.contains(thread) else {
                    return
                }
                self.messageThreads.append(thread)
            }
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.isToolbarHidden = false
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.isToolbarHidden = true
    }
    
    // MARK: - Actions
    
    @objc private func signOut() {
        let ac = UIAlertController(title: nil, message: "Are you sure you want to sign out?", preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "Sign Out", style: .destructive, handler: { _ in
            do {
                try Auth.auth().signOut()
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }))
        present(ac, animated: true, completion: nil)
    }
    
    @objc private func addButtonPressed() {
        let ac = UIAlertController(title: "Create a new message thread", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addTextField { field in
            field.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
            field.enablesReturnKeyAutomatically = true
            field.autocapitalizationType = .words
            field.clearButtonMode = .whileEditing
            field.placeholder = "Message Thread name"
            field.returnKeyType = .done
            field.tintColor = .primary
        }
        
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { _ in
            self.createChannel()
        })
        createAction.isEnabled = false
        ac.addAction(createAction)
        ac.preferredAction = createAction
        
        present(ac, animated: true) {
            ac.textFields?.first?.becomeFirstResponder()
        }
        currentChannelAlertController = ac
    }
    
    @objc private func textFieldDidChange(_ field: UITextField) {
        guard let ac = currentChannelAlertController else {
            return
        }
        
        ac.preferredAction?.isEnabled = field.hasText
    }
    
    // MARK: - Helpers
    
    // when chat is tapped
    private func createChannel() {
        guard let ac = currentChannelAlertController else {
            return
        }
        
        guard let channelName = ac.textFields?.first?.text else {
            return
        }
        
        let messageThread = MessageThread(name: channelName).representation
        messageThreadReference.addDocument(data: messageThread) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }
       /* chattingUserMessageThreadReference.addDocument(data: messageThread) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
        }*/
        
    }

    private func addChannelToTable(_ messageThread: MessageThread) {
        guard !messageThreads.contains(messageThread) else {
            return
        }
        
        messageThreads.append(messageThread)
        messageThreads.sort()
        
        guard let index = messageThreads.index(of: messageThread) else {
            return
        }
        tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func updateChannelInTable(_ messageThread: MessageThread) {
        guard let index = messageThreads.index(of: messageThread) else {
            return
        }
        
        messageThreads[index] = messageThread
        tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func removeChannelFromTable(_ messageThread: MessageThread) {
        guard let index = messageThreads.index(of: messageThread) else {
            return
        }
        
        messageThreads.remove(at: index)
        tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
    }
    
    private func handleDocumentChange(_ change: DocumentChange) {
        guard let messageThread = MessageThread(document: change.document) else {
            return
        }
        
        switch change.type {
        case .added:
            addChannelToTable(messageThread)
            
        case .modified:
            updateChannelInTable(messageThread)
            
        case .removed:
            removeChannelFromTable(messageThread)
        }
    }
    

   
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return messageThreads.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: messageThreadCellIdentifier, for: indexPath)

        cell.accessoryType = .disclosureIndicator
        cell.textLabel?.text = messageThreads[indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messageThread = messageThreads[indexPath.row]
        let vc = ChatViewController(user: currentUser!, messageThread: messageThread, chattingUserUID: chattingUserUID!)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMessages" {
            guard let destinationVC = segue.destination as? ChatViewController else { return }
            
            
            
        }
    }*/
    

}
