//
//  User.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 4/30/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import MessageKit

// https://awkdate.firebaseio.com/

class User: Codable {
    
    static private let uidKey = "identifier"
    static private let firstNameKey = "firstName"
    static private let lastNameKey = "lastName"
    static private let emailKey = "emailAddress"
    static private let passwordKey = "password"
    static private let ageKey = "age"
    static private let genderKey = "gender"
    static private let mainPhotoKey = "mainPhoto"
    static private let zipcodeKey = "zipcode"
    static private let conditionKey = "condition"
    static private let biographyKey = "biography"
    static private let likedMatchesKey = "likedMatches"
    static private let messagesKey = "messages"
    static private let photoLibraryKey = "photoLibrary"
    
    var email: String
    var password: String
    var identifier: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var mainPhoto: Photo
    var zipcode: Int
   // var bio: String?
    var condition: [String]
    
    var biography: String
    var likedMatches: [Profile]
    var messages: [MessageThread]
    var photoLibrary: [Photo]
    
    init(email: String, password: String, identifier: String, firstName: String, lastName: String, age: Int, gender: String, mainPhoto: Photo, zipcode: Int, biography: String = "", condition: [String], likedMatches: [Profile] = [], messages: [MessageThread] = [], photoLibrary: [Photo] = []) {
        self.email = email
        self.password = password
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
        self.mainPhoto = mainPhoto
        self.zipcode = zipcode
        self.biography = biography
        self.condition = condition
        self.likedMatches = likedMatches
        self.messages = messages
        self.photoLibrary = photoLibrary
    }
    
    var dictionaryRepresentation: NSDictionary {
        return [User.emailKey: email, User.passwordKey: password, User.firstNameKey: firstName, User.lastNameKey: lastName, User.ageKey: age, User.genderKey: gender, User.mainPhotoKey: mainPhoto, User.zipcodeKey: zipcode, User.biographyKey: biography, User.conditionKey: condition, User.likedMatchesKey: likedMatches, User.messagesKey: messages, User.photoLibraryKey: photoLibrary] as NSDictionary
    }
    
    func toAnyObject() -> Dictionary<String, Any> {
        return [User.emailKey: email, User.passwordKey: password, User.firstNameKey: firstName, User.lastNameKey: lastName, User.ageKey: age, User.genderKey: gender, User.mainPhotoKey: [mainPhoto.imageData.description, mainPhoto.caption], User.zipcodeKey: zipcode, User.biographyKey: biography, User.conditionKey: condition, User.likedMatchesKey: likedMatches, User.messagesKey: messages, User.photoLibraryKey: photoLibrary]
    }

}

struct Photo: Equatable, Codable {
    
    var imageData: Data
    var caption: String

}

struct Profile: Codable {
    
    
    var identifier: String
    var name: String
    var age: Int
    var gender: String
    var zipcode: Int
    var condition: [String]
    var mainPhoto: Photo
    var photoLibrary: [Photo]
    var biography: String
    var isLiked: Bool
    
    func toAnyObject() -> Dictionary<String, Any> {
        return ["identifier": identifier, "name": name, "age": age, "gender": gender, "mainPhoto": [mainPhoto.imageData.description, mainPhoto.caption], "zipcode": zipcode, "biography": biography, "condition": condition, "isLiked": isLiked.description, "photoLibrary": photoLibrary]
    }
    
}
