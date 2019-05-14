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

        
    }
    
    @IBAction func loginTapped(_ sender: UIButton) {
        
        userController.login(withEmail: "test22@unblushtest.com", andPassword: "testtest22") { (error) in
            if let error = error {
                print("Error logging in: \(error)")
                return
            }
            AppSettings.displayName = self.userController.serverCurrentUser?.displayName ?? "John"
            self.currentUser = self.userController.serverCurrentUser!
            print("User: \(self.currentUser)")
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "toThreads", sender: self)
            }
            
        }
        
    }
    
    var currentUser: User?
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toThreads" {
            guard let vc = segue.destination as? MessageThreadsTableViewController else { return }
            
            //vc.init(currentUser: self.currentUser)
            //(currentUser: self.currentUser)
            vc.currentUser = currentUser
        }
    }
    

}
