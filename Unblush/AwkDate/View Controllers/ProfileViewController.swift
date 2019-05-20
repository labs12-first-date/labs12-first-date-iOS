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
    
    var currentUser: User?
    var age: Int?
    var zipcode: Int?
    var gender: GenderType?
    var lookingFor = [LookingForType]()
    var userCondition = [ConditionType]()
    
    //MARK: - Outlets
    @IBOutlet weak var notLikeButton: UIButton!
    @IBAction func notLikeButton(_ sender: Any) {
        
    }
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButton(_ sender: Any) {
        
    }
    @IBOutlet weak var matchesButton: UIBarButtonItem!
    @IBAction func matchesButton(_ sender: Any) {
        
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
   
    @IBOutlet weak var messageButton: UIButton!
    @IBAction func messageButton(_ sender: Any) {
        performSegue(withIdentifier: "messages", sender: self)

    }
    @IBOutlet weak var mediaButton: UIButton!
    @IBAction func mediaButton(_ sender: Any) {
        performSegue(withIdentifier: "media", sender: self)

    }
    @IBOutlet weak var settingsButton: UIButton!
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: self)

    }
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButton(_ sender: Any) {
        
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
                AppSettings.displayName = self.user2Controller!.serverCurrentUser?.displayName
                self.currentUser = self.user2Controller!.serverCurrentUser!
                
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
                
                //self.chattingUserUID = "qgWMqM5HWtTEMMygiJIWTOvR4m63" // uid of test23
                //self.chattingUserUID = "AMi53uJuuubUv3gp5coQ7ZRk1xH3"
                print("User in profile vc: \(self.currentUser!.uid)")
                
                
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
            
        }
        if segue.identifier == "showMutallyLiked" {
            guard let vc = segue.destination as? MutuallyLikedCollectionViewController else { return }
            
            //vc.init(currentUser: self.currentUser)
            //(currentUser: self.currentUser)
            // vc.currentUser = self.currentUser
            vc.userController = self.user2Controller
            
            //vc.chattingUserUID = self.chattingUserUID
        }
    }
}
