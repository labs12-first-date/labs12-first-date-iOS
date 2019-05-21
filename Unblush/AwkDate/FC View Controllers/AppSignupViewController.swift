//
//  SignupViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class AppSignupViewController: UIViewController {
    
    //MARK: - Properties
    let user2Controller = User2Controller()
    var currentUserUID: String?
    var email: String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var retypePasswordLabel: UILabel!
    @IBOutlet weak var retypePasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBAction func signupButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = retypePasswordTextField.text else {
            NSLog("Fields are empty")
            return
        }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
        myActivityIndicator.style = (UIActivityIndicatorView.Style.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.view.addSubview(myActivityIndicator)
        }
        
        if password == confirmPassword {
            user2Controller.createUserAccount(withEmail: email, andPassword: password) { (error) in
                if let error = error {
                    NSLog("Error creating account in vc: \(error.localizedDescription)")
                    self.displayMessage(userMessage: "\(error.localizedDescription)")
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    return
                }
                self.email = email
                self.currentUserUID = self.user2Controller.currentUserUID
                
                DispatchQueue.main.async {
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    self.performSegue(withIdentifier: "getInfoFromSignup", sender: self)
                }
            }
            
        } else {
            // display message
            self.displayMessage(userMessage: "Passwords do not match!")
            return
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setNeedsStatusBarAppearanceUpdate()

    }
    
    func setTheme() {
        emailTextField.setPadding()
        passwordTextField.setPadding()
        retypePasswordTextField.setPadding()
        
        emailTextField.textColor = .grape
        passwordTextField.textColor = .grape
        retypePasswordTextField.textColor = .grape
        
        emailTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        passwordTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        retypePasswordTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        
        AppearanceHelper.style(button: signupButton)
        
        view.backgroundColor = .violet
    }
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Please Try Again", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            self.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "getInfoFromSignup" {
                guard let destination = segue.destination as? UINavigationController,
                    let vcDestination = destination.topViewController as? UserInfoViewController else { return }
                    
                vcDestination.currentUserUID = self.currentUserUID
                vcDestination.user2Controller = self.user2Controller
                vcDestination.email = self.email
            }
    }
}

//extension UIViewController {
//
//    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
//    {
//        DispatchQueue.main.async
//            {
//                activityIndicator.stopAnimating()
//                activityIndicator.removeFromSuperview()
//        }
//    }
//
//}
