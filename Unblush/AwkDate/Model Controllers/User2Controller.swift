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

            if let userLocal = user {
                self.putProfileToServer(userID: userLocal.user.uid, firstName: "Bob", lastName: "Blue", email: email, dob: dateFormatter.date(from: "06 15, 1999")!, gender: "Male", zipcode: 23456, condition: ["Herpes"], mainPhoto: self.currentPhoto!, lookingFor: "Same", biography: "Nothing", completion: completion)
            }
            
        }
        
        
    }
    
    func putProfileToServer(userID: String, firstName: String, lastName: String, email: String, dob: Date, gender: String, zipcode: Int, condition: [String], mainPhoto: Data, lookingFor: String, biography:String,  completion: @escaping (Error?) -> Void = {_ in }) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"
        
        let exampleProfile = Profile(firstName: "Joe", lastName: "Blue", email: "test14@test.com", dob: dateFormatter.date(from: "05 22, 1997")!, gender: "Male", zipcode: 23456, condition: ["Herpes"], mainPhoto: self.currentPhoto!, likedMatches: [[:]], lookingFor: "Same", biography: "Nothing really", matches: [[:]])
        
        let profile = Profile(firstName: firstName, lastName: lastName, email: email, dob: dob, gender: gender, zipcode: zipcode, condition: condition, mainPhoto: mainPhoto, likedMatches: [exampleProfile.toAnyObject() as NSDictionary], lookingFor: lookingFor, biography: biography, matches: [exampleProfile.toAnyObject() as NSDictionary])
        
        //.. /profiles/uid
        
        var ref: DocumentReference? = nil
        ref = db.collection("profiles").document(userID)
        
        if ref != nil {
            ref?.setData(profile.toAnyObject())
        }
        
        
        //addDocument(data: profile.toAnyObject())
    }
    
    func uploadPhoto(imageContainer: Data) {
        self.currentPhoto = imageContainer
    }
    
    
}
