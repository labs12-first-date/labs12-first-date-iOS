//
//  BogusMutuallyLikedCollectionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/16/19.
//  Copyright © 2019 JS. All rights reserved.
//

//import UIKit
//import FirebaseFirestore
//import FirebaseAuth
//
//private let reuseIdentifier = "MutualCell"
//
//class BogusMutuallyLikedCollectionViewController: UICollectionViewController {
//
//
//    var userController: User2Controller?
//    //var currentUser: User?
//
//    var mutallyLikedArray = [[String:Any]]()
//    var messageThread: MessageThread?
//
//     private let db = Firestore.firestore()
//
//    private var messageThreadReference: CollectionReference {
//        return db.collection("messageThreadsiOS").document(self.userController!.serverCurrentUser!.uid).collection("threads")
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        let userLikedArray = userController!.singleProfileFromServer["liked"] as! [[String:Any]]
//
//        userController!.fetchCompareProfileFromServer(userID: "qSQ3rFkLvAY976huM75w3E5ex0i2") { (error) in
//            if let error = error {
//                print("error fetching compared profile in vc: \(error)")
//            }
//            print("Successfully fetched the comparison profile")
//            for user in userLikedArray {
//                let userEmailString = user["email"] as! String
//                let compareEmailString = self.userController!.compareProfileFromServer["email"] as! String
//                if userEmailString == compareEmailString {
//                    self.mutallyLikedArray.append(self.userController!.compareProfileFromServer)
//                    DispatchQueue.main.async {
//                        self.collectionView.reloadData()
//                    }
//                }
//
//            }
//        }
//
//
//        // we need the current user uid and the other user uid for chatting and checking mutually liked
//
//    }
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using [segue destinationViewController].
//        // Pass the selected object to the new view controller.
//
//     // showMutallyLiked
//    }
//    */
//
//    // MARK: UICollectionViewDataSource
//
//    override func numberOfSections(in collectionView: UICollectionView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//
//
//    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of items
//        return mutallyLikedArray.count
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BogusMutualCollectionViewCell
//
//        let profile = self.mutallyLikedArray[indexPath.item]
//
//        cell.layer.borderWidth = 2
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.cornerRadius = 8
//
//        cell.profileImageView.image = self.load(fileName: profile["profile_picture"] as! String)
//        cell.ageLabel.text = profile["age"] as! String
//        cell.bioLabel.text = profile["bio"] as! String
//        cell.locationLabel.text = profile["zip_code"] as! String
//        cell.nameLabel.text = profile["first_name"] as! String
//
//        cell.profile = profile
//        cell.userController = self.userController
//
//
//        return cell
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let profile = mutallyLikedArray[indexPath.item]
//        let userName = profile["first_name"] as! String
//        let messageThread = MessageThread(name: userName)
//
//        //let messageThreadWithID = MessageThread()
//
//        messageThreadReference.addDocument(data: messageThread.representation) { error in
//            if let e = error {
//                print("Error saving channel: \(e.localizedDescription)")
//            }
//
//            self.messageThreadReference.getDocuments(completion: { (querySnapshot, error) in
//                if let error = error {
//                    print("Error fetching messages from id: \(error)")
//                    return
//                }
//
//                guard let querySnap = querySnapshot else {
//                    print("No query snapshot")
//                    return
//                }
//
//                for document in querySnap.documents {
//                    print("Document msg: \(document)")
//                    let thread = MessageThread(document: document)!
//                    if thread.name == userName {
//                        let vc =  ChatViewController(user: self.userController!.serverCurrentUser!, messageThread: thread, chattingUserUID: "qSQ3rFkLvAY976huM75w3E5ex0i2")
//
//                        self.navigationController?.pushViewController(vc, animated: true)
//                    }
//                }
//
//
//            })
//
//
//        }
//
//
//    }
//
//    private func load(fileName: String) -> UIImage? {
//        print("file name: \(fileName)")
//        let url = NSURL(string: fileName)
//        let newURL = NSURL(string: fileName)
//
//        let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
//        let imageUrl: URL = URL(fileURLWithPath: imagePath)
//        do {
//            let imageData = try Data(contentsOf: newURL! as URL)
//            print("Image data: \(imageData)")
//            return UIImage(data: imageData)
//        } catch {
//            print("Error loading image : \(error)")
//        }
//        return nil
//    }
//
//    // MARK: UICollectionViewDelegate
//
//    /*
//    // Uncomment this method to specify if the specified item should be highlighted during tracking
//    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment this method to specify if the specified item should be selected
//    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
//        return true
//    }
//    */
//
//    /*
//    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
//    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
//        return false
//    }
//
//    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
//
//    }
//    */
//
//}
