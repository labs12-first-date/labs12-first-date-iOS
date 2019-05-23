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

class ProfileViewController: UIViewController {
    
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
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var matchesButton: UIBarButtonItem!
    @IBAction func matchesButton(_ sender: Any) {
        
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
   
    @IBOutlet weak var messageButton: UIButton!
    @IBAction func messageButton(_ sender: Any) {
        //performSegue(withIdentifier: "toThreads", sender: self)

    }
    
    @IBOutlet weak var settingsButton: UIButton!
    @IBAction func settingsButton(_ sender: Any) {
       // performSegue(withIdentifier: "settings", sender: self)

    }
    @IBOutlet weak var likedButton: UIButton!
    @IBAction func likedButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var signoutButton: UIBarButtonItem!
    @IBAction func signoutButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTheme()
        setNeedsStatusBarAppearanceUpdate()

        
        if self.photo == nil {
            user2Controller?.fetchProfileFromServer(userID: currentUserUID!, completion: { (error) in
                if let error = error {
                    print("Error fetching profile in profile vc: \(error)")
                    return
                }
                let photoData = self.load(fileName: self.user2Controller?.singleProfileFromServer["profile_picture"] as! String)
                self.nameLabel.text = (self.user2Controller?.singleProfileFromServer["first_name"] as! String)
                
                self.currentUserFirstName = (self.user2Controller?.singleProfileFromServer["first_name"] as! String)
                self.photo = photoData
                
                
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
                
            })
        }
        

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
    
    func setupTheme() {
        
        cardView.backgroundColor = UIColor.grape.withAlphaComponent(0.15)
        cardView.layer.cornerRadius = 20
        nameLabel.textColor = .grape
        nameLabel.font = AppearanceHelper.mediumFont(with: .subheadline, pointSize: 25)
        
        profileView.layer.cornerRadius = profileView.frame.size.width / 2
        profileView.clipsToBounds = true
        
        view.backgroundColor = .violet
        
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

