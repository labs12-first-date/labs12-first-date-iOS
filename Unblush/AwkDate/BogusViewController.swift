//
//  BogusViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/13/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import FirebaseAuth

class BogusViewController: UIViewController {
    
    let userController = User2Controller()

    override func viewDidLoad() {
        super.viewDidLoad()
        do {
            try Auth.auth().signOut()
            print("User in view did load: \(userController.serverCurrentUser?.uid)")

        } catch {
            print("error")
        }
        
        
    }
    
   @IBAction func loginTapped(_ sender: UIButton) {
        
        userController.login(withEmail: "test27@unblushtest.com", andPassword: "testtest27") { (error) in
            if let error = error {
                print("Error logging in: \(error)")
                return
            }
            AppSettings.displayName = self.userController.singleProfileFromServer["first_name"] as! String
            self.currentUser = self.userController.serverCurrentUser!
            //self.chattingUserUID = "qgWMqM5HWtTEMMygiJIWTOvR4m63" // uid of test23
            self.chattingUserUID = "VnqVnRqzeEfzBeqFPnzdbfdHQ7d2"
            print("User: \(self.currentUser!.uid)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toThreads", sender: self)
            }
            
        }
        
    }
    
    var currentUser: User?
    var chattingUserUID: String?
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThreads" {
            guard let vc = segue.destination as? MessageThreadsTableViewController else { return }
            
            //vc.init(currentUser: self.currentUser)
            //(currentUser: self.currentUser)
            vc.currentUser = self.currentUser
            vc.chattingUserUID = self.chattingUserUID
        }
    }
    
    
    // segue = showMatches
    
   // var currentUser: User?
    var age: Int?
    var zipcode: Int?
    var gender: GenderType?
    var lookingFor = [LookingForType]()
    var userCondition = [ConditionType]()
    
   /* @IBAction func loginButtonTapped(_ sender: UIButton) {
        userController.login(withEmail: "test25@unblushtest.com", andPassword: "testtest25") { (error) in
            if let error = error {
                print("Error logging in: \(error)")
                return
            }
            AppSettings.displayName = self.userController.serverCurrentUser?.displayName
            self.currentUser = self.userController.serverCurrentUser!
            
            let ageString = self.userController.singleProfileFromServer["age"] as! String
            self.age = Int(ageString)!
            
            let zipString = self.userController.singleProfileFromServer["zip_code"] as! String
            self.zipcode = Int(zipString)!
            
            let genderString = self.userController.singleProfileFromServer["gender"] as! String
            self.gender = GenderType(rawValue: genderString)!
            
            let lookingStringArray = self.userController.singleProfileFromServer["looking_for"] as! [String]
            
            for look in lookingStringArray {
                self.lookingFor.append(LookingForType(rawValue: look)!)
            }
            
            
            let conditionStringArray = self.userController.singleProfileFromServer["condition"] as! [String]
            
            for cond in conditionStringArray {
                self.userCondition.append(ConditionType(rawValue: cond)!)
            }
            
            //self.chattingUserUID = "qgWMqM5HWtTEMMygiJIWTOvR4m63" // uid of test23
            //self.chattingUserUID = "AMi53uJuuubUv3gp5coQ7ZRk1xH3"
            print("User in bogus vc: \(self.currentUser!.uid)")
            
        }
        
    }*/
   /*
    @IBAction func matchesButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showMatches", sender: self)
        }
    }
    
    @IBAction func mutallyLikedButtonTapped(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "showMutallyLiked", sender: self)
        }
        
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
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
    }*/
    
 /*   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showMatches" {
            guard let vc = segue.destination as? BogusMatchesCollectionViewController else { return }
            
            //vc.init(currentUser: self.currentUser)
            //(currentUser: self.currentUser)
            vc.currentUser = self.currentUser
            vc.userController = self.userController
            vc.age = self.age
            vc.gender = self.gender
            vc.zipcode = self.zipcode
            vc.lookingFor = self.lookingFor
            vc.userCondition = self.userCondition
            //vc.chattingUserUID = self.chattingUserUID
        }
        if segue.identifier == "showMutallyLiked" {
            guard let vc = segue.destination as? BogusMutuallyLikedCollectionViewController else { return }
            
            //vc.init(currentUser: self.currentUser)
            //(currentUser: self.currentUser)
           // vc.currentUser = self.currentUser
            vc.userController = self.userController
            
            //vc.chattingUserUID = self.chattingUserUID
        }
    }*/
    
}
