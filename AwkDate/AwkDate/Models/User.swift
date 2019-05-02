//
//  User.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 4/30/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

// https://awkdate.firebaseio.com/

class User: Codable {
    
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
    var condition: [STD]
    
    var biography: String?
    var likedMatches: [Profile]?
    var message: [MessageThread]?
    var photoLibray: [Photo]?
    
    init(email: String, password: String, identifier: String, firstName: String, lastName: String, age: Int, gender: String, mainPhoto: Photo, zipcode: Int, biography: String?, condition: [STD], likedMatches: [Profile]?, message: [MessageThread]?, photoLibrary: [Photo]?) {
        self.email = email
        self.password = password
        self.identifier = identifier
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.gender = gender
        self.mainPhoto = mainPhoto
        self.zipcode = zipcode
        self.biography = biography ?? ""
        self.condition = condition
        self.likedMatches = likedMatches ?? []
        self.message = message ?? []
        self.photoLibray = photoLibrary ?? []
    }

}

struct Photo: Equatable, Codable {
    
    var imageData: Data
    var caption: String?

}

struct Profile: Codable {
    
    var identifier: String
    var name: String
    var age: Int
    var zipcode: Int
    var condition: [String]
    var mainPhoto: Data
    var photoLibrary: [Data]?
    var biography: String
    var isLiked: Bool
    
}

struct STD: Codable {
    var title: String
}


