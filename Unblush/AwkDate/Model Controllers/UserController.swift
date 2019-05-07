//
//  UserController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/1/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth
import Firebase

/*class UserController {
    
    let baseURL = URL(string: "https://awkdate.firebaseio.com/")!
    let userRef = Database.database().reference(withPath: "users")
    let profileRef = Database.database().reference(withPath: "profiles")
    let db = Firestore.firestore()
    
    
    var serverCurrentUser = Auth.auth().currentUser
    var localCurrentUser: User?
    var currentPhoto: Photo?
    
    let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
    
    func createUserAccount(withEmail email: String, andPassword password: String, andFirst firstName: String, andLast lastName: String, age: Int, gender: String, mainPhoto: Data, zipcode: Int, biography: String?, condition: [String], completion: @escaping (Error?) -> Void) {
        
        let likedMatches: [Profile] = []
        //let message:[MessageThread] =  [MessageThread(title: "Shane Lowe", messages: [MessageThread.Message(text: "Hi", senderName: "Shane Lowe")], identifier: "fakeIdentifier")]
        let message:[MessageThread] = []
        let photoLibrary:[Photo] = []
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            
            if let error = error {
                NSLog("Error creating user account: \(error)")
                completion(error)
                return
            }
            
            if let userAccount = user {
                let userLocal = User(email: email, password: password, identifier: userAccount.user.uid, firstName: firstName, lastName: lastName, age: age, gender: gender, mainPhoto: self.currentPhoto!, zipcode: zipcode, biography: biography ?? "", condition: condition, likedMatches: likedMatches, messages: message, photoLibrary: photoLibrary)

                if Auth.auth().currentUser?.uid == userLocal.identifier {
                    print("The same uid!")
                    self.localCurrentUser = userLocal
                    self.putUserToServer(user: userLocal, completion: completion)
                    self.putProfileToServer(user: userLocal)
                    self.changeRequest?.displayName = userLocal.firstName
                    self.changeRequest?.commitChanges(completion: { (error) in
                        print("Created display name")
                    })
                }
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
            
           /* if let userAccount = user {
                self.userFound = true
                self.fetchSingleEntryFromServer(userId: userAccount.user.uid, completion: completion)
            }*/
        }
    }
    
    func updateMessages(user: User, messageThread: MessageThread, completion: @escaping (Error?) -> Void = {_ in }) {
        
        let ref = userRef.child(user.identifier).updateChildValues(["messages": messageThread])
        
      
    }
    
    func putProfileToServer(user: User, completion: @escaping (Error?) -> Void = {_ in }) {
        let identifier = user.identifier
        
        let profile = Profile(identifier: identifier, name: user.firstName, age: user.age, gender: user.gender, zipcode: user.zipcode, condition: user.condition, mainPhoto: user.mainPhoto, photoLibrary: user.photoLibrary, biography: user.biography, isLiked: false)
        
        let specificProfileRef = self.profileRef.child(identifier)
        
        specificProfileRef.setValue(profile.toAnyObject())
    }
    
    func putUserToServer(user: User, completion: @escaping (Error?) -> Void = {_ in }) {
        let identifier = user.identifier
        
       /* var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: user.dictionaryRepresentation as! [String : Any]) */
        
        
        let specificUserRef = self.userRef.child(identifier)
        
        specificUserRef.setValue(user.toAnyObject())
        
        
      /*
        let urlPlusUser = baseURL.appendingPathComponent("users")
        let urlPlusID = urlPlusUser.appendingPathComponent(identifier)
        let urlPlusJSON = urlPlusID.appendingPathExtension("json")
        
        var request = URLRequest(url: urlPlusJSON)
        request.httpMethod = "PUT"
        
        do {
            let encoder = JSONEncoder()
            let userJSON = try encoder.encode(user)
            request.httpBody = userJSON
        } catch {
            NSLog("Error encoding user: \(error)")
            completion(error)
            return
        }
        
        URLSession.shared.dataTask(with: request) { (_, _, error) in
            if let error = error {
                NSLog("Error putting user to the server: \(error)")
                completion(error)
                return
            }
            
            completion(nil)
            print("Done creating user!: \(user.firstName)")
            }.resume() */
      
    }
    
    
    func uploadPhoto(imageContainer: Data, caption: String?) {
        let photo = Photo(imageData: imageContainer, caption: caption ?? "")
        self.currentPhoto = photo
    }
    
    /*
 
 func update(photo: Photo, imageContainer: Data, imageTitle: String) {
 guard let index = photos.index(of: photo) else { return }
 photos[index].imageData = imageContainer
 photos[index].title = imageTitle
 
 }
*/
    
}
*/
