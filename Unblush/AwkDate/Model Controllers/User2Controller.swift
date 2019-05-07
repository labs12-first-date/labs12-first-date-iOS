//
//  User2Controller.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/7/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import Firebase


class User2Controller {
    
    let db = Firestore.firestore()
    var currentPhoto: Data?
    func createUserAccount(withEmail email: String, andPassword password: String, completion: @escaping (Error?) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"

        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                NSLog("Error creating user account: \(error)")
                completion(error)
                return
            }
        }
    }
            
}
