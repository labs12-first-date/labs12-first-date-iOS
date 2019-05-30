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
    
    let opQueue = OperationQueue()
    var messageThread: MessageThread?
    
    private let db = Firestore.firestore()
    
    private var messageThreadReference: CollectionReference {
        return db.collection("messageThreadsiOS").document(self.userController!.serverCurrentUser!.uid).collection("threads")
    }
    
    func setTheme() {
        collectionView.backgroundColor = .violet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Unable to retrieve layout")
        }
        
        let amount: CGFloat = 40
        layout.sectionInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
        layout.itemSize = CGSize(width: 285, height: 400)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setNeedsStatusBarAppearanceUpdate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews(notification:)), name: .updateCollection, object: nil)
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
        myActivityIndicator.style = (UIActivityIndicatorView.Style.whiteLarge)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.view.addSubview(myActivityIndicator)
        }
        
        let image = UIImage(named: "NoMutuals")
        let imageView = UIImageView(image: image!)
        
        let emptyArray = [[String:Any]]()
        mutallyLikedArray = [[String:Any]]()

        let userLikedArray = userController!.singleProfileFromServer["liked"] as! [[String:Any]]
        
        let userEmail = userController!.singleProfileFromServer["email"] as! String
        
        if userLikedArray.count == emptyArray.count {
            print("No liked users")
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
            imageView.center = self.view.center
            self.view.addSubview(imageView)
            return
        }
    
        let filteredArray = filterByDisliked(profiles: userLikedArray)
        let mutualsArray = filterIfMutuallyLiked(profiles: filteredArray)
        mutallyLikedArray.append(contentsOf: mutualsArray)
        
       /* for user in filteredArray {
           // let id = user["user_uid"] as! String
            
            let compareUserLikedArray = user["liked"] as! [[String:Any]]
            
            for compareUser in compareUserLikedArray {
                let compareEmail = compareUser["email"] as! String
                if compareEmail == userEmail {
                    mutallyLikedArray.append(user)
                }
            }
            
        }*/
        
        
        DispatchQueue.main.async {
            if mutallyLikedArray.count == 0 {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                imageView.center = self.view.center
                self.view.addSubview(imageView)
                return
            }
            print("In Mutually Liked Array: \(mutallyLikedArray.count)")
            imageView.alpha = 0
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
    
    func filterIfMutuallyLiked(profiles: [[String:Any]]) -> [[String:Any]] {
        var profilesFiltered = [[String:Any]]()
        let userEmail = userController!.singleProfileFromServer["email"] as! String
        
        for user in profiles {
            // let id = user["user_uid"] as! String
            print("Entering loop")
            let compareUserLikedArray = user["liked"] as! [[String:Any]]
            if compareUserLikedArray.contains(where: { $0["email"] as! String == userEmail }) {
                profilesFiltered.append(user)
            }
            
        }

        print("Mutually liked filter: \(profilesFiltered.count)")
        return profilesFiltered
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
            if userDislikedArray.contains(where: { $0["email"] as! String == profile["email"] as! String }) {
                print("Contains this: \(profile)")
            } else {
                profilesFiltered.append(profile)
            }
        }
        print("Disliked filter mutually liked: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
  
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
        cell.profile = profile
        loadImage(forCell: cell, forItemAt: indexPath)
        
        //cell.layer.borderWidth = 2
        //cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.layer.backgroundColor = UIColor.grape.cgColor
        
        cell.theirAgeLabel.text = profile["age"] as! String
        cell.biographyLabel.text = profile["bio"] as! String
        cell.zipcodeLabel.text = profile["zip_code"] as! String
        cell.firstNameLabel.text = profile["first_name"] as! String
        
        
        cell.userController = self.userController
        
       /* otherOP.addDependency(loadPhotoOP)
        OperationQueue.main.addOperation(otherOP)
        opQueue.addOperation(loadPhotoOP)*/
    
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
    
   /* override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let profileRef = mutallyLikedArray[indexPath.item]
        
        let name = profileRef["profile_picture"] as! String
        
        if let operation = convertOperations[name] {
            operation.cancel()
        }
    }*/
    
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
    
    private let cache = Cache<String, UIImage>()
    var convertOperations: [String: ConvertPhotoOperation] = [:]
    let photoConvertQueue = OperationQueue()
    
    private func loadImage(forCell cell: LikedCollectionViewCell, forItemAt indexPath: IndexPath) {
        let profileRef = mutallyLikedArray[indexPath.item]
        
        let name = profileRef["profile_picture"] as! String
        
        if let cacheImage = cache.value(for: name) {
            cell.personPhotoView.image = cacheImage
        } else {
            
            let convertPhotoOp = ConvertPhotoOperation(fileName: name)
            convertOperations[name] = convertPhotoOp
            
            let storeImageOp = BlockOperation {
                guard let loadedPhoto = convertPhotoOp.image else { return }
                self.cache.cache(value: loadedPhoto, for: name)
            }
            
            let reuseOp = BlockOperation {
                guard let currentIndex = self.collectionView.indexPath(for: cell), let loadedPhoto = convertPhotoOp.image else { return }
                
                if currentIndex == indexPath {
                    cell.personPhotoView.image = loadedPhoto
                    
                } else {
                    return
                }
                
            }
            
            storeImageOp.addDependency(convertPhotoOp)
            reuseOp.addDependency(convertPhotoOp)
            
            photoConvertQueue.addOperation(convertPhotoOp)
            photoConvertQueue.addOperation(storeImageOp)
            OperationQueue.main.addOperation(reuseOp)
            
        }
        
        
        
        
    }
}

