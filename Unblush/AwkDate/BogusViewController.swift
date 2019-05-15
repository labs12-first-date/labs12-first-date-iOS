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
        
        print("User in view did load: \(userController.serverCurrentUser?.uid)")
        
    }
    
   /* @IBAction func loginTapped(_ sender: UIButton) {
        
        userController.login(withEmail: "test23@unblushtest.com", andPassword: "testtest23") { (error) in
            if let error = error {
                print("Error logging in: \(error)")
                return
            }
            AppSettings.displayName = self.userController.serverCurrentUser?.displayName ?? "Samantha"
            self.currentUser = self.userController.serverCurrentUser!
            //self.chattingUserUID = "qgWMqM5HWtTEMMygiJIWTOvR4m63" // uid of test23
            self.chattingUserUID = "AMi53uJuuubUv3gp5coQ7ZRk1xH3"
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
    */
    
    // segue = showMatches
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func matchesButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func mutallyLikedButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
    }
    
    
    
}
