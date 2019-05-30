//
//  ProfileViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore
import Firebase

class ProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    //MARK: - Properties
    var user2Controller: User2Controller?
    var currentUserUID: String?
    var profile: Profile?
    
    // Messaging
    var chattingUserUID: String?
    
    // Matches
    var currentUser: User?
    var age: Int?
    var zipcode: Int?
    var gender: GenderType?
    var lookingFor = [LookingForType]()
    var userCondition = [ConditionType]()
    var radius: Int?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    @IBOutlet weak var matchesButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var messageButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var signOutButton: UIButton!
    
    let domain = Bundle.main.bundleIdentifier!
    let defaults = UserDefaults.standard
    @IBOutlet weak var editPicButton: UIButton!
    @IBAction func editPicButtonTapped(_ sender: Any) {
        presentImagePickerController()
    }
    
    @IBAction func signOutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            defaults.removePersistentDomain(forName: domain)
            defaults.synchronize()
            print(Array(defaults.dictionaryRepresentation().keys).count)
        }
        catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
        
        let storyboard = UIStoryboard(name: "RevisedMain", bundle: nil)
        let initial = storyboard.instantiateInitialViewController()
        UIApplication.shared.keyWindow?.rootViewController = initial
    }
    
    // share var photo across view controllers, so that we don't have to keep network calling every time we come back to profile
    var photo: UIImage?
    var currentUserFirstName: String?
    
    func updateViews() {
        guard let photo = photo else { return }
        
        profileView.image = photo

    }
    
    let opQueue = OperationQueue()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        
        //to hide back bar item
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        //for status bar to be white
        setNeedsStatusBarAppearanceUpdate()
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews(notification:)), name: .updateCollection, object: nil)

        
        if self.photo != nil {
            var photoImage = UIImage()
            photoImage = self.load(fileName: self.user2Controller?.singleProfileFromServer["profile_picture"] as! String)!
            self.nameLabel.text = (self.user2Controller?.singleProfileFromServer["first_name"] as! String)
            self.photo = photoImage
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        user2Controller?.fetchProfileFromServer(userID: currentUserUID!, completion: { (error) in
            if let error = error {
                print("Error fetching profile in profile vc: \(error)")
                return
            }
            
            if self.photo == nil {
                var photoImage = UIImage()
                photoImage = self.load(fileName: self.user2Controller?.singleProfileFromServer["profile_picture"] as! String)!
                self.nameLabel.text = (self.user2Controller?.singleProfileFromServer["first_name"] as! String)
                self.bioLabel.text = (self.user2Controller?.singleProfileFromServer["bio"] as! String)
                self.photo = photoImage
            }
            
            self.bioLabel.text = (self.user2Controller?.singleProfileFromServer["bio"] as! String)
            
            
            
            let photoData = BlockOperation {
                
            }
            
            let setProperties = BlockOperation {
                
            }
            //self.bioLabel.text = (self.user2Controller?.singleProfileFromServer["bio"] as! String)
            
            self.currentUserFirstName = (self.user2Controller?.singleProfileFromServer["first_name"] as! String)
            
            
            // Properties for Matches
            AppSettings.displayName = self.currentUserFirstName!
            self.currentUser = self.user2Controller!.serverCurrentUser!
            let radiusString = self.user2Controller!.singleProfileFromServer["max_distance"] as! String
            self.radius = Int(radiusString)!
            
            let ageString = self.user2Controller!.singleProfileFromServer["age"] as! String
            self.age = Int(ageString)!
            
            let zipString = self.user2Controller!.singleProfileFromServer["zip_code"] as! String
            self.zipcode = Int(zipString)!
            
            let genderString = self.user2Controller!.singleProfileFromServer["gender"] as! String
            self.gender = GenderType(rawValue: genderString)!
            
            let lookingStringArray = self.user2Controller!.singleProfileFromServer["looking_for"] as! [String]
            
            for look in lookingStringArray {
                self.lookingFor.append(LookingForType(rawValue: look)!)
            }
            
            
            let conditionStringArray = self.user2Controller!.singleProfileFromServer["condition"] as! [String]
            
            for cond in conditionStringArray {
                self.userCondition.append(ConditionType(rawValue: cond)!)
            }
            
            
            print("User in profile vc: \(self.currentUser!.uid)")
            
            
            //self.chattingUserUID = "qSQ3rFkLvAY976huM75w3E5ex0i2"
            
            
            DispatchQueue.main.async {
                self.updateViews()
            }
            
            
            /* setProperties.addDependency(photoData)
             OperationQueue.main.addOperation(setProperties)
             self.opQueue.addOperation(photoData)*/
            
        })
        
        
    }
    
    private let cache = Cache<String, UIImage>()
    private let photoConvertQueue = OperationQueue()
    
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
        
       /* if let cachedImage = cache.value(for: fileName) {
            return cachedImage
        }
        print("file name: \(fileName)")
        var loadedPhoto: UIImage?
        
        let cacheOp = BlockOperation {
            if let photo = loadedPhoto {
                self.cache.cache(value: photo, for: fileName)
            }
            //return photo
        }
        
        let makePhotoOp = BlockOperation {
            let url = NSURL(string: fileName)
            let newURL = NSURL(string: fileName)
            
            let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
            let imageUrl: URL = URL(fileURLWithPath: imagePath)
            do {
                let imageData = try Data(contentsOf: newURL! as URL)
                loadedPhoto = UIImage(data: imageData)!
               // print("Image data: \(imageData)")
                //return UIImage(data: imageData)
            } catch {
                print("Error loading image : \(error)")
                }
        }
        cacheOp.addDependency(makePhotoOp)
        photoConvertQueue.addOperation(makePhotoOp)
        //return nil*/
    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            NSLog("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        //imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        //imageView.contentMode = .scaleAspectFit
        //profileView.image = image
        
        dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func setupTheme() {
        editPicButton.tintColor = UIColor.grape.withAlphaComponent(0.2)
        
        bioLabel.textColor = .grape
        bioLabel.font = AppearanceHelper.lightFont(with: .caption1, pointSize: 17)
    
        nameLabel.textColor = .grape
        nameLabel.font = AppearanceHelper.lightFont(with: .subheadline, pointSize: 33)
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        profileView.clipsToBounds = true
        
        AppearanceHelper.style(button: signOutButton)
        
        view.backgroundColor = .violet
    }
    
    @objc func updateViews(notification: NSNotification) {
      
        user2Controller?.fetchProfileFromServer(userID: user2Controller!.currentUserUID!, completion: { (error) in
            if let error = error {
                print("Error fetching profile from server in update views: \(error)")
                return
            }
            print("Successfully fetched new profile after updating views")
        })
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMatches" {
            guard let vc = segue.destination as? MatchUsersCollectionViewController else { return }
            
            vc.currentUser = self.currentUser
            vc.userController = self.user2Controller
            vc.age = self.age
            vc.gender = self.gender
            vc.zipcode = self.zipcode
            vc.lookingFor = self.lookingFor
            vc.userCondition = self.userCondition
            vc.radius = self.radius
            
        }
        if segue.identifier == "showMutallyLiked" {
            guard let vc = segue.destination as? MutuallyLikedCollectionViewController else { return }
            
            //vc.init(currentUser: self.currentUser)
            //(currentUser: self.currentUser)
            // vc.currentUser = self.currentUser
            vc.userController = self.user2Controller
            
            //vc.chattingUserUID = self.chattingUserUID
        }
        if segue.identifier == "toThreads" {
            guard let vc = segue.destination as? MessageThreadsTableViewController else { return }
            
            vc.currentUser = self.currentUser
            vc.chattingUserUID = self.chattingUserUID
        }
        if segue.identifier == "settings" {
            guard let vc = segue.destination as? BogusSettingsViewController else { return }
            
            vc.userController = self.user2Controller
        }
    }
}

