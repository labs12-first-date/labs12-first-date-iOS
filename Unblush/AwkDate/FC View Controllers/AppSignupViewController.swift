//
//  SignupViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class AppSignupViewController: UIViewController, UITextFieldDelegate {
    
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
        myActivityIndicator.style = (UIActivityIndicatorView.Style.whiteLarge)
        
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
            user2Controller.createUserAccount(withEmail: email.lowercased(), andPassword: password) { (error) in
                if let error = error {
                    NSLog("Error creating account in vc: \(error.localizedDescription)")
                    self.displayMessage(userMessage: "\(error.localizedDescription)")
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    return
                }
                self.email = email
                self.currentUserUID = self.user2Controller.currentUserUID
                let pushManager = PushNotificationManager(userID: self.currentUserUID!)
                pushManager.registerForPushNotifications()
                
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
    /*
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }*/
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setNeedsStatusBarAppearanceUpdate()
        
       // self.retypePasswordTextField.delegate = self

    }
    
    func setTheme() {
        emailTextField.setPadding()
        passwordTextField.setPadding()
        retypePasswordTextField.setPadding()
        
        emailLabel.textColor = .grass
        passwordLabel.textColor = .grass
        retypePasswordLabel.textColor = .grass
        
        emailLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        passwordLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        retypePasswordLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        
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
                            alertController.dismiss(animated: true, completion: nil)
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

extension UITextField {
    
    @IBInspectable var doneAccessory: Bool{
        get{
            return self.doneAccessory
        }
        set (hasDone) {
            if hasDone{
                addDoneButtonOnKeyboard()
            }
        }
    }
    
    func addDoneButtonOnKeyboard()
    {
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))
        
        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()
        
        self.inputAccessoryView = doneToolbar
    }
    
    @objc func doneButtonAction()
    {
        self.resignFirstResponder()
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
