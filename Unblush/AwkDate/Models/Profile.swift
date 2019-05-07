//
//  Profile.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/7/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

/*enum LookingFor {
 
}*/

struct Profile: Codable {
    
    
    static private let firstNameKey = "first_name"
    static private let lastNameKey = "last_name"
    static private let emailKey = "email"
    static private let dobKey = "date_of_birth"
    static private let genderKey = "gender"
    static private let mainPhotoKey = "main_photo"
    static private let zipcodeKey = "zip"
    static private let conditionKey = "condition"
    static private let biographyKey = "bio"
    static private let likedMatchesKey = "liked"
    static private let matchesKey = "matches"
    static private let lookingForKey = "looking_for"
   // static private let photoLibraryKey = "photos"
    
    
    var firstName: String
    var lastName: String
    var email: String
    var dob: Date
    var gender: String // enum
    var zipcode: Int
    var condition: [String]
    var mainPhoto: Data
   // var photoLibrary: [Photos]
    //var likedMatches: [Profile]
    
    var lookingFor: String // enum
    var biography: String
   // var isLiked: Bool
    
   // var matches: [Profile]
    
    func toAnyObject() -> Dictionary<String, Any> {
        return [Profile.firstNameKey: firstName, Profile.lastNameKey: lastName, Profile.genderKey: gender, Profile.mainPhotoKey: mainPhoto.description, Profile.zipcodeKey: NSNumber(value: zipcode), Profile.biographyKey: biography, Profile.conditionKey: condition, Profile.dobKey: dob.description, Profile.emailKey: email, Profile.lookingForKey: lookingFor]
    }
    
    
    
}

struct Photos {
    var photoURLs: [URL]
}
