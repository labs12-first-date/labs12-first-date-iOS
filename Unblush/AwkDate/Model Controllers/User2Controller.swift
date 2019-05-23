//
//  User2Controller.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/7/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage


class User2Controller {
    
    let db = Firestore.firestore()
    var singleProfileFromServer: [String: Any] = [:]
    var profilesFromServer = [[String: Any]]()
    var currentUserUID: String?
    var compareProfileFromServer = [String: Any]()
    
    var currentPhoto: Data?
    var currentPhotoURL: URL?
    let storage = Storage.storage()
    
    var serverCurrentUser = Auth.auth().currentUser
    
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    
    func createUserAccount(withEmail email: String, andPassword password: String, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                NSLog("Error creating user account: \(error)")
                completion(error)
                return
            }
            
            if let userLocal = user {
                self.currentUserUID = userLocal.user.uid
                self.serverCurrentUser = user?.user
                print("Current user in create user func: \(user!.user)")
                completion(nil)
            }
            
        }
        
        
    }
    
    func login(withEmail email: String, andPassword password: String, completion: @escaping (Error?) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                NSLog("Error finding user account: \(error)")
                completion(error)
                return
            }
            
            if let userAccount = user {
               // self.userFound = true
                self.currentUserUID = userAccount.user.uid
                self.serverCurrentUser = user?.user
                print("Current user in login func: \(user!.user)")
                self.fetchProfileFromServer(userID: userAccount.user.uid, completion: completion)
            }
        }
    }
    
    func putProfileToServer(userID: String, firstName: String, lastName: String, email: String, age: Int, gender: String, zipcode: Int, condition: [String], mainPhoto: URL?, lookingFor: [String], biography: String, completion: @escaping (Error?) -> Void = {_ in }) {
        
       
       // let exampleProfile = Profile(firstName: "Joe", lastName: "Blue", email: "test14@test.com", dob: dateFormatter.date(from: "05/22/1997")!, gender: "Male", zipcode: 23456, condition: ["Herpes"], mainPhoto: self.currentPhotoURL!, likedMatches: [[:]], lookingFor: "Same", biography: "Nothing really", matches: [[:]])
        
        let photoUID = UUID().uuidString
        let matchesEmpty = [[String:Any]]()
        let likedEmpty = [[String:Any]]()
        let dislikedEmpty = [[String:Any]]()
        
        let storageRef = self.storage.reference()
        let imagesRef = storageRef.child("images")
        
        let userPhotosRef = storageRef.child("images/\(photoUID).png")
        
        userPhotosRef.putData(self.currentPhoto!, metadata: nil, completion: { (metadata, error) in
            
            if let error = error {
                print("Error putting image to storage: \(error)")
                return
            }
            
            // Adds a name property for the authentication 'user'
            self.changeRequest?.displayName = firstName
            self.changeRequest?.commitChanges(completion: { (error) in
                print("Created display name")
            })
            
            userPhotosRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    print("Error downloading url: \(error)")
                    return
                }
                self.currentPhotoURL = url
                let profile = Profile(firstName: firstName, lastName: lastName, email: email, age: age, gender: gender, zipcode: zipcode, condition: condition, mainPhoto: self.currentPhotoURL!, likedMatches: likedEmpty, lookingFor: lookingFor, biography: biography, matches: matchesEmpty, userUID: userID, dislikedMatches: dislikedEmpty)
                   // [[:]])
                
                var ref: DocumentReference? = nil
                ref = self.db.collection("profilesiOS").document(userID)
                
                if ref != nil {
                    ref?.setData(profile.toAnyObject())
                    completion(nil)
                }
                
            })
            
        })
        
       // let profile = Profile(firstName: firstName, lastName: lastName, email: email, dob: dob, gender: gender, zipcode: zipcode, condition: condition, mainPhoto: mainPhoto, likedMatches: [exampleProfile.toAnyObject() as NSDictionary], lookingFor: lookingFor, biography: biography, matches: [exampleProfile.toAnyObject() as NSDictionary])
        
        //.. /profiles/uid
        
        
        
        
        //addDocument(data: profile.toAnyObject())
        //completion(nil)
    }
    
    func fetchProfileFromServer(userID: String, completion: @escaping (Error?) -> Void = {_ in }) {
        let profileRef = db.collection("profilesiOS").document(userID)
        
        profileRef.getDocument { (document, error) in
            
            if let error = error {
                print("Error fetching single profile from server: \(error)")
                completion(error)
                return
            }
            
           // let jsonDecoder = JSONDecoder()
            
            if let document = document, document.exists {
                self.singleProfileFromServer = document.data()!
                print("Document data: \(document.data()!)")
                print("Photo from fetch: \( self.singleProfileFromServer["first_name"])")
                completion(nil)
            } else {
                print("Document does not exist")
                completion(error)
                return
            }
            
            
        }
        
        
    }
    
    func fetchCompareProfileFromServer(userID: String, completion: @escaping (Error?) -> Void = {_ in }) {
        let profileRef = db.collection("profilesiOS").document(userID)
        
        profileRef.getDocument { (document, error) in
            
            if let error = error {
                print("Error fetching single profile from server: \(error)")
                completion(error)
                return
            }
            
            // let jsonDecoder = JSONDecoder()
            
            if let document = document, document.exists {
                self.compareProfileFromServer = document.data()!
                completion(nil)
            } else {
                print("Document does not exist")
                completion(error)
                return
            }
            
            
        }
        
        
    }
    
    func fetchAllProfilesFromServer(completion: @escaping (Error?) -> Void = {_ in }) {
        
        db.collection("profilesiOS").getDocuments { (querySnapshot, error) in
            if let error = error {
                print("Error fetching ALL profiles: \(error)")
                return
            }
            
            guard let querySnap = querySnapshot else {
                print("No querySnapshot!")
                return
            }
            
           // var count = 0
            for profile in querySnap.documents {
               
                if (profile["email"] as! String) != self.serverCurrentUser?.email! {
                    self.profilesFromServer.append(profile.data())
                }
                
                if self.profilesFromServer.count == (querySnap.documents.count - 1) {
                    // (querySnap.documents.count - (count + 1))
                    completion(nil)
                }
            }
            
            
        }
      
    }
    
    func updateLikedMatchesOnServer(userUID: String, likedMatch: [String:Any], completion: @escaping (Error?) -> Void = {_ in }) {
        
        let profileRef = db.collection("profilesiOS").document(userUID)
        
        var oldLiked = self.singleProfileFromServer["liked"] as! [[String:Any]]
        oldLiked.append(likedMatch)
        print("Updated liked matches: \(oldLiked)")
        
        profileRef.updateData(["liked" : oldLiked]) { (error) in
            if let error = error {
                print("Error updating data: \(error)")
                completion(error)
                return
            }
            print("Successfully updated liked matches")
            completion(nil)
        }
        
        
    }
    
    func updateMaxDistanceOnServer(userUID: String, maxDistance: String, completion: @escaping (Error?) -> Void = {_ in }) {
        
        let profileRef = db.collection("profilesiOS").document(userUID)
        
        profileRef.updateData(["max_distance": maxDistance]) { (error) in
            if let error = error {
                print("Error updating max distance: \(error)")
                completion(error)
                return
            }
            print("Successfully updated distance")
            completion(nil)
        }
        
    }
    
    func updateGenderOnServer(userUID: String, gender: String, completion: @escaping (Error?) -> Void = {_ in }) {
        
        let profileRef = db.collection("profilesiOS").document(userUID)
        
        profileRef.updateData(["gender": gender]) { (error) in
            if let error = error {
                print("Error updating gender: \(error)")
                completion(error)
                return
            }
            print("Successfully updated gender")
            completion(nil)
        }
        
    }
    func updateZipcodeOnServer(userUID: String, zipcode: String, completion: @escaping (Error?) -> Void = {_ in }) {
        
        let profileRef = db.collection("profilesiOS").document(userUID)
        
        profileRef.updateData(["zip_code": zipcode]) { (error) in
            if let error = error {
                print("Error updating gender: \(error)")
                completion(error)
                return
            }
            print("Successfully updated gender")
            completion(nil)
        }
        
    }
    
    func updateAgeRangeOnServer(userUID: String, ageGap: String, completion: @escaping (Error?) -> Void = {_ in }) {
        
        let profileRef = db.collection("profilesiOS").document(userUID)
        
        var oldLookingForArray = self.singleProfileFromServer["looking_for"] as! [String]
        for oldGap in oldLookingForArray {
            let index = oldLookingForArray.firstIndex(of: oldGap)!
            if oldGap == LookingForType.fiveYearAgeGap.rawValue && oldGap != ageGap {
                oldLookingForArray.remove(at: index)
            } else if oldGap == LookingForType.threeYearAgeGap.rawValue && oldGap != ageGap{
                oldLookingForArray.remove(at: index)
            } else if oldGap == LookingForType.tenYearAgeGap.rawValue && oldGap != ageGap {
                oldLookingForArray.remove(at: index)
            }
        }
        
        oldLookingForArray.append(ageGap)
        
        profileRef.updateData(["looking_for": oldLookingForArray]) { (error) in
            if let error = error {
                print("Error updating age gap: \(error)")
                completion(error)
                return
            }
            print("Successfully updated age gap!")
            completion(nil)
        }
        
    }
    
    func updateDisLikedMatchesOnServer(userUID: String, dislikedMatch: [String:Any], completion: @escaping (Error?) -> Void = {_ in }) {
        
        let profileRef = db.collection("profilesiOS").document(userUID)
        
        var olddisLiked = self.singleProfileFromServer["disliked"] as! [[String:Any]]
        olddisLiked.append(dislikedMatch)
        print("Updated liked matches: \(olddisLiked)")
        
        profileRef.updateData(["disliked" : olddisLiked]) { (error) in
            if let error = error {
                print("Error updating data: \(error)")
                completion(error)
                return
            }
            print("Successfully updated liked matches")
            completion(nil)
        }
        
        
    }
    
    
    func uploadPhoto(imageContainer: Data) {
        self.currentPhoto = imageContainer
    }
    
    
}
