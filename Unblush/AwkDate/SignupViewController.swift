//
//  SignupViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordLabel: UILabel!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBAction func signupButton(_ sender: Any) {
        if passwordTextField.text != retypePasswordTextField.text {
            let alertController = UIAlertController(title: "Password Incorrect", message: "Please re-type password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alertController.addAction(defaultAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
        else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!){ (user, error) in
                
                if error == nil {
                    self.performSegue(withIdentifier: "signupToLogin", sender: self)
                }
                else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    
                    alertController.addAction(defaultAction)
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

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
