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

struct Profile: Decodable {
    
    
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
    
    enum CodingKeys: String, CodingKey {
        case likedMatches = "liked"
        case matches = "matches"
        case firstNameKey = "first_name"
        case lastNameKey = "last_name"
        case emailKey = "email"
        case dobKey = "date_of_birth"
        case genderKey = "gender"
        case mainPhotoKey = "main_photo"
        case zipcodeKey = "zip"
        case conditionKey = "condition"
        case biographyKey = "bio"
        case lookingForKey = "looking_for"
    }
    
    
    var firstName: String
    var lastName: String
    var email: String
    var dob: Date
    var gender: String // enum
    var zipcode: Int
    var condition: [String]
    var mainPhoto: Data
    // var photoLibrary: [Photos]
    var likedMatches: [Any] //[Profile] converted to dict in user controller
    
    var lookingFor: String // enum
    var biography: String
    // var isLiked: Bool
    
    var matches: [Any]
   
    func toAnyObject() -> Dictionary<String, Any> {
        return [Profile.firstNameKey: firstName, Profile.lastNameKey: lastName, Profile.genderKey: gender, Profile.mainPhotoKey: mainPhoto.description, Profile.zipcodeKey: NSNumber(value: zipcode).stringValue, Profile.biographyKey: biography, Profile.conditionKey: condition, Profile.dobKey: dob.description, Profile.emailKey: email, Profile.lookingForKey: lookingFor, Profile.likedMatchesKey: likedMatches, Profile.matchesKey: matches]
    }
    
  
    
    init(firstName: String, lastName: String, email: String, dob: Date, gender: String, zipcode: Int, condition: [String], mainPhoto: Data, likedMatches: [Any], lookingFor: String, biography: String, matches: [Any]) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.dob = dob
        self.gender = gender
        self.zipcode = zipcode
        self.condition = condition
        self.mainPhoto = mainPhoto
        self.likedMatches = likedMatches
        self.lookingFor = lookingFor
        self.biography = biography
        self.matches = matches
        
    }
    
  /*  init?(dictionary: [String: Any]) {
        guard let firstName = dictionary[Profile.firstNameKey], let lastName = dictionary[Profile.lastNameKey], let email = dictionary[Profile.emailKey], let dob = dictionary[Profile.dobKey], let gender = dictionary[Profile.genderKey], let zipcode = dictionary[Profile.zipcodeKey], let condition = dictionary[Profile.conditionKey], let mainPhoto = dictionary[Profile.mainPhotoKey], let likedMatches = dictionary[Profile.likedMatchesKey], let lookingFor = dictionary[Profile.lookingForKey], let biography = dictionary[Profile.biographyKey], let matches = dictionary[Profile.matchesKey] else { return nil }
        
        self.init(firstName: firstName as! String, lastName: lastName as! String, email: email as! String, dob: dob as! Date, gender: gender, zipcode: zipcode, condition: condition, mainPhoto: mainPhoto, likedMatches: likedMatches, lookingFor: lookingFor, biography: biography, matches: matches)
        
        
    }*/
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let likedContainer = try container.decode([Any].self, forKey: .likedMatches)
        let matchesContainer = try container.decode([Any].self, forKey: .matches)
        let first = try container.decode(String.self, forKey: .firstNameKey)
        let last = try container.decode(String.self, forKey: .lastNameKey)
        let emailAddress = try container.decode(String.self, forKey: .emailKey)
        let dateOB = try container.decode(String.self, forKey: .dobKey)
        let genderString = try container.decode(String.self, forKey: .genderKey)
        let zip = try container.decode(String.self, forKey: .zipcodeKey)
        let conditionString = try container.decode([String].self, forKey: .conditionKey)
        let mainPhotoString = try container.decode(String.self, forKey: .mainPhotoKey)
        let lookingForString = try container.decode(String.self, forKey: .lookingForKey)
        let bio = try container.decode(String.self, forKey: .biographyKey)
        
        let dateFormatter = DateFormatter()
       
        
        self.likedMatches = likedContainer
        self.matches = matchesContainer
        self.firstName = first
        self.lastName = last
        self.email = emailAddress
        self.dob =  dateFormatter.date(from: dateOB)!
        self.gender = genderString
        self.zipcode = Int(zip)!
        self.condition = conditionString
        self.mainPhoto = mainPhotoString.data(using: .utf8)!
        self.lookingFor = lookingForString
        self.biography = bio
    }
    
}



struct Photos {
    var photoURLs: [URL]
}

/*enum QuantumValue: Decodable {
    
    case arr([String]), string(String)
    
    init(from decoder: Decoder) throws {
        if let arr = try? decoder.singleValueContainer().decode([String].self) {
            self = .arr(arr)
            return
        }
        
        if let string = try? decoder.singleValueContainer().decode(String.self) {
            self = .string(string)
            return
        }
        
        throw QuantumError.missingValue
    }
    
    enum QuantumError:Error {
        case missingValue
    }
}*/


struct JSONCodingKeys: CodingKey {
    var stringValue: String
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    var intValue: Int?
    
    init?(intValue: Int) {
        self.init(stringValue: "\(intValue)")
        self.intValue = intValue
    }
}


extension KeyedDecodingContainer {
    
    func decode(_ type: Dictionary<String, Any>.Type, forKey key: K) throws -> Dictionary<String, Any> {
        let container = try self.nestedContainer(keyedBy: JSONCodingKeys.self, forKey: key)
        return try container.decode(type)
    }
    
    func decodeIfPresent(_ type: Dictionary<String, Any>.Type, forKey key: K) throws -> Dictionary<String, Any>? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }
    
    func decode(_ type: Array<Any>.Type, forKey key: K) throws -> Array<Any> {
        var container = try self.nestedUnkeyedContainer(forKey: key)
        return try container.decode(type)
    }
    
    func decodeIfPresent(_ type: Array<Any>.Type, forKey key: K) throws -> Array<Any>? {
        guard contains(key) else {
            return nil
        }
        guard try decodeNil(forKey: key) == false else {
            return nil
        }
        return try decode(type, forKey: key)
    }
    
    func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        var dictionary = Dictionary<String, Any>()
        
        for key in allKeys {
            if let boolValue = try? decode(Bool.self, forKey: key) {
                dictionary[key.stringValue] = boolValue
            } else if let stringValue = try? decode(String.self, forKey: key) {
                dictionary[key.stringValue] = stringValue
            } else if let intValue = try? decode(Int.self, forKey: key) {
                dictionary[key.stringValue] = intValue
            } else if let doubleValue = try? decode(Double.self, forKey: key) {
                dictionary[key.stringValue] = doubleValue
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self, forKey: key) {
                dictionary[key.stringValue] = nestedDictionary
            } else if let nestedArray = try? decode(Array<Any>.self, forKey: key) {
                dictionary[key.stringValue] = nestedArray
            }
        }
        return dictionary
    }
}

extension UnkeyedDecodingContainer {
    
    mutating func decode(_ type: Array<Any>.Type) throws -> Array<Any> {
        var array: [Any] = []
        while isAtEnd == false {
            // See if the current value in the JSON array is `null` first and prevent infite recursion with nested arrays.
            if try decodeNil() {
                continue
            } else if let value = try? decode(Bool.self) {
                array.append(value)
            } else if let value = try? decode(Double.self) {
                array.append(value)
            } else if let value = try? decode(String.self) {
                array.append(value)
            } else if let nestedDictionary = try? decode(Dictionary<String, Any>.self) {
                array.append(nestedDictionary)
            } else if let nestedArray = try? decode(Array<Any>.self) {
                array.append(nestedArray)
            }
        }
        return array
    }
    
    mutating func decode(_ type: Dictionary<String, Any>.Type) throws -> Dictionary<String, Any> {
        
        let nestedContainer = try self.nestedContainer(keyedBy: JSONCodingKeys.self)
        return try nestedContainer.decode(type)
    }
}
