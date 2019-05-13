//
//  BogusViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/13/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

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
            self.performSegue(withIdentifier: "toThreads", sender: self)
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
