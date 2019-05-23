//
//  ChooseSignupOrLoginViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ChooseSignupOrLoginViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "signup", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
    }
}
