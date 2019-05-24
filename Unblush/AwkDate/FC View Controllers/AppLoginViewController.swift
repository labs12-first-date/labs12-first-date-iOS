//
//  LoginViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class AppLoginViewController: UIViewController {
    
    //MARK: - Properties
    let user2Controller = User2Controller()
    var currentUserUID: String?
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButton(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
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
        
        user2Controller.login(withEmail: email, andPassword: password) { (error) in
            if let error = error {
                NSLog("Error logging in vc: \(error.localizedDescription)")
                self.displayMessage(userMessage: "\(error.localizedDescription)")
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                return
            }
            
            self.currentUserUID = self.user2Controller.currentUserUID
            
            DispatchQueue.main.async {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                self.performSegue(withIdentifier: "loginToProfile", sender: self)
            }
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
        
        emailLabel.textColor = .grass
        passwordLabel.textColor = .grass
        
        emailLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        passwordLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)

        emailTextField.textColor = .grape
        passwordTextField.textColor = .grape
        
        emailTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        passwordTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        
        AppearanceHelper.style(button: loginButton)
        
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
        if segue.identifier == "loginToProfile" {
            guard let destination = segue.destination as? ProfileViewController else { return }
            
            destination.currentUserUID = self.currentUserUID
            destination.user2Controller = user2Controller
        }
    }
}

//extension AppLoginViewController {
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
