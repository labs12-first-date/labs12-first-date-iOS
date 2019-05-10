//
//  ViewControllerMethods.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/9/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

/*
let user2Controller = User2Controller()

var currentUserID: String?

func loginButtonTapped() {
    
    guard let email = emailTextField.text, let password = passwordTextField.text else {
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
    
    user2Controller.login(withEmail: email, andPassword: password) { (error) in
        if let error = error {
            NSLog("Error logging in vc: \(error.localizedDescription)")
            self.displayMessage(userMessage: "\(error.localizedDescription)")
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            return
        }
        
         self.currentUserID = self.user2Controller.currentUserUID
        
        DispatchQueue.main.async {
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            self.performSegue(withIdentifier: "FromLogintoHome", sender: self)
        }
        
        
    }
    
}


func signUpTapped() {
    
    guard let email = emailTextField.text, let password = passwordTextField.text, let confirmPassword = confirmTextField.text else {
        NSLog("Fields are empty")
        return
    }
    
    if password == confirmPassword {
        user2Controller.createUserAccount(withEmail: email, andPassword: password) { (error) in
            if let error = error {
                NSLog("Error creating account in vc: \(error.localizedDescription)")
                self.displayMessage(userMessage: "\(error.localizedDescription)")
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                return
            }
            
            self.currentUserID = self.user2Controller.currentUserUID
            
            DispatchQueue.main.async {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                self.performSegue(withIdentifier: "FromLogintoHome", sender: self)
            }
            
            
            
        }
        
        
    } else {
        // display message
        self.displayMessage(userMessage: "Passwords do not match!")
        return
    }
    
    
    
    
}


func createProfileOnServer() {
    
    // guard statement for everything except userID
    
    user2Controller.putProfileToServer(userID: self.currentUserUID, firstName: "Jocelyn", lastName: <#T##String#>, email: <#T##String#>, dob: <#T##Date#>, gender: <#T##String#>, zipcode: <#T##Int#>, condition: <#T##[String]#>, mainPhoto: <#T##Data#>, lookingFor: <#T##String#>, biography: <#T##String#>) { (error) in
        if let error = error {
            print("Error puting profile to server: \(error)")
            return
        }
        
        
    }
    
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
*/
