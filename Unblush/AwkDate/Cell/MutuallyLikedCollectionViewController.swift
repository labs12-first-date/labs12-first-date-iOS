//
//  MutuallyLikedCollectionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/20/19.
//  Copyright © 2019 JS. All rights reserved.
//
import UIKit
import FirebaseFirestore
import FirebaseAuth

private let reuseIdentifier = "MutualCell"
var mutallyLikedArray = [[String:Any]]()

class MutuallyLikedCollectionViewController: UICollectionViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var userController: User2Controller?
    //var currentUser: User?
    
    
    var messageThread: MessageThread?
    
    private let db = Firestore.firestore()
    
    private var messageThreadReference: CollectionReference {
        return db.collection("messageThreadsiOS").document(self.userController!.serverCurrentUser!.uid).collection("threads")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews(notification:)), name: .updateCollection, object: nil)
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
        myActivityIndicator.style = (UIActivityIndicatorView.Style.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.view.addSubview(myActivityIndicator)
        }
        
        let emptyArray = [[String:Any]]()

        let userLikedArray = userController!.singleProfileFromServer["liked"] as! [[String:Any]]
        
        let userEmail = userController!.singleProfileFromServer["email"] as! String
        
        if userLikedArray.count == emptyArray.count {
            print("No liked users")
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            return
        }
    
        let filteredArray = filterByDisliked(profiles: userLikedArray)
        
        for user in filteredArray {
           // let id = user["user_uid"] as! String
            
            let compareUserLikedArray = user["liked"] as! [[String:Any]]
            
            for compareUser in compareUserLikedArray {
                let compareEmail = compareUser["email"] as! String
                if compareEmail == userEmail {
                    mutallyLikedArray.append(user)
                    
                }
            }
            
        }
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            return
        }
        
        /*userController!.fetchCompareProfileFromServer(userID: "qSQ3rFkLvAY976huM75w3E5ex0i2") { (error) in
            if let error = error {
                print("error fetching compared profile in vc: \(error)")
            }
            print("Successfully fetched the comparison profile")
            for user in userLikedArray {
                let userEmailString = user["email"] as! String
                let compareEmailString = self.userController!.compareProfileFromServer["email"] as! String
                if userEmailString == compareEmailString {
                    self.mutallyLikedArray.append(self.userController!.compareProfileFromServer)
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    }
                }
                
            }
        }
        */
        
        // we need the current user uid and the other user uid for chatting and checking mutually liked
        
    }
    
    func filterByDisliked(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        let emptyArray = [[String:Any]]()
        let userDislikedArray = userController!.singleProfileFromServer["disliked"] as! [[String:Any]]
        
        if userDislikedArray.count == emptyArray.count {
            profilesFiltered = profiles
            return profilesFiltered
        }
        
        for profile in profiles {
            let likedEmail = profile["email"] as! String
            for disliked in userDislikedArray {
                let dislikedEmail = disliked["email"] as! String
                if dislikedEmail != likedEmail {
                    profilesFiltered.append(profile)
                }
            }
        }
        print("Disliked filter mutually liked: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     
     // showMutallyLiked
     }
     */
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return mutallyLikedArray.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LikedCollectionViewCell
        
        let profile = mutallyLikedArray[indexPath.item]
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 8
        
        cell.photoView.image = self.load(fileName: profile["profile_picture"] as! String)
        cell.ageLabel.text = profile["age"] as! String
        cell.bioLabel.text = profile["bio"] as! String
        cell.locationLabel.text = profile["zip_code"] as! String
        cell.nameLabel.text = profile["first_name"] as! String
        
        cell.profile = profile
        cell.userController = self.userController
        
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let profile = mutallyLikedArray[indexPath.item]
        let userName = profile["first_name"] as! String
        let chattingUserID = profile["user_uid"] as! String
        let messageThread = MessageThread(name: userName, chattingUserUID: chattingUserID)
        let index = mutallyLikedArray.firstIndex(where: { $0["email"] as! String == profile["email"] as! String })
        
        //let messageThreadWithID = MessageThread()
        
        
        // check server current user
        messageThreadReference.addDocument(data: messageThread.representation) { error in
            if let e = error {
                print("Error saving channel: \(e.localizedDescription)")
            }
            
            self.messageThreadReference.getDocuments(completion: { (querySnapshot, error) in
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
                    if thread.name == userName {
                        let vc =  ChatViewController(user: self.userController!.serverCurrentUser!, messageThread: thread, chattingUserUID: chattingUserID)
                        
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
                self.userController?.updateDisLikedMatchesOnServer(userUID: self.userController!.currentUserUID!, dislikedMatch: profile, completion: { (error) in
                    if let error = error {
                        print("Error updating disliked matches after chat now pressed")
                        return
                    }
                    mutallyLikedArray.remove(at: index!)
                    print("Successfully updated disliked matches after chat now pressed")
                    NotificationCenter.default.post(name: .updateCollection, object: nil)
                })
                
                
            })
            
            
        }
        
        
    }
    
    @objc func updateViews(notification: NSNotification) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        userController?.fetchProfileFromServer(userID: userController!.currentUserUID!, completion: { (error) in
            if let error = error {
                print("Error fetching profile from server in update views: \(error)")
                return
            }
            print("Successfully fetched new profile after updating views")
        })
    }
    
    private func load(fileName: String) -> UIImage? {
        print("file name: \(fileName)")
        let url = NSURL(string: fileName)
        let newURL = NSURL(string: fileName)
        
        let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        do {
            let imageData = try Data(contentsOf: newURL! as URL)
            print("Image data: \(imageData)")
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }
    
    // MARK: UICollectionViewDelegate
    
    /*
     // Uncomment this method to specify if the specified item should be highlighted during tracking
     override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment this method to specify if the specified item should be selected
     override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
     return true
     }
     */
    
    /*
     // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
     override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
     return false
     }
     
     override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
     
     }
     */
    
}
