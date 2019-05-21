//
//  Profile.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/7/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation

enum LookingForType: String {
    case sameGender = "Same Gender as Me"
    case sameCondition = "Same Condition as Me"
    case openToAllPossibilities = "Open to all possibilities"
    case openToAllConditions = "Open to all conditions"
    case fiveYearAgeGap = "Only 5 year age gap"
    case tenYearAgeGap = "Only 10 year age gap"
    case threeYearAgeGap = "Only 3 year age gap"
}

enum ConditionType: String {
    case aids = "AIDS"
    case hiv = "HIV"
    case herpes = "Herpes"
    case chlamydia = "Chlamydia"
    case theClap = "The Clap"
    case hepC = "Hep C"
    case hepB = "Hep B"
    case hepA = "Hep A"
    case hepD = "Hep D"
    case genitalWarts = "Genital Warts"
    case crabs = "Crabs"
    case gonorrhea = "Gonorrhea"
    case syphyllis = "Syphyllis"
}

enum GenderType: String {
    case female = "Female"
    case male = "Male"
    case nonbinary = "Non-binary"
    case transgender = "Trans"
    case questioning = "Questioning"
    case other = "Other"
}

struct Profile: Decodable {
    
    static private let firstNameKey = "first_name"
    static private let lastNameKey = "last_name"
    static private let emailKey = "email"
    static private let ageKey = "age"
    static private let genderKey = "gender"
    static private let mainPhotoKey = "profile_picture"
    static private let zipcodeKey = "zip_code"
    static private let conditionKey = "condition"
    static private let biographyKey = "bio"
    static private let likedMatchesKey = "liked"
    static private let matchesKey = "matches"
    static private let lookingForKey = "looking_for"
    static private let maxDistanceKey = "max_distance"
    static private let userUIDKey = "user_uid"
   // static private let photoLibraryKey = "photos"
    
    enum CodingKeys: String, CodingKey {
        case likedMatches = "liked"
        case matches = "matches"
        case firstNameKey = "first_name"
        case lastNameKey = "last_name"
        case emailKey = "email"
        case ageKey = "age"
        case genderKey = "gender"
        case mainPhotoKey = "profile_picture"
        case zipcodeKey = "zip_code"
        case conditionKey = "condition"
        case biographyKey = "bio"
        case lookingForKey = "looking_for"
        case maxDistanceKey = "max_distance"
        case userUIDKey = "user_uid"
    }
    
    var maxDistance: Int
    var userUID: String
    var firstName: String
    var lastName: String
    var email: String
    var age: Int
    var gender: String // enum
    var zipcode: Int
    var condition: [String]
    var mainPhoto: URL //Data
    // var photoLibrary: [Photos]
    var likedMatches: [Any] //[Profile] converted to dict in user controller
    
    var lookingFor: [String] // enum
    var biography: String
    // var isLiked: Bool
    
    var matches: [Any]
   
    func toAnyObject() -> Dictionary<String, Any> {
       // let mainPhotoString = String(data: mainPhoto, encoding: .utf8)!
       // let mainPhotoURL = URL(string: String(mainPhotoString))!
        //let mainPhotoURL2 = URL(dataRepresentation: mainPhoto, relativeTo: nil)!
        
        return [Profile.userUIDKey: userUID, Profile.firstNameKey: firstName, Profile.lastNameKey: lastName, Profile.genderKey: gender, Profile.mainPhotoKey: mainPhoto.absoluteString, Profile.zipcodeKey: NSNumber(value: zipcode).stringValue, Profile.maxDistanceKey: NSNumber(value: maxDistance).stringValue, Profile.biographyKey: biography, Profile.conditionKey: condition, Profile.ageKey: String(age), Profile.emailKey: email, Profile.lookingForKey: lookingFor, Profile.likedMatchesKey: likedMatches, Profile.matchesKey: matches]
    }
    
  
    
    init(firstName: String, lastName: String, email: String, age: Int, gender: String, zipcode: Int, condition: [String], mainPhoto: URL, likedMatches: [Any], lookingFor: [String], biography: String, matches: [Any], userUID: String, maxDistance: Int = 25) {
        
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.age = age
        self.gender = gender
        self.zipcode = zipcode
        self.condition = condition
        self.mainPhoto = mainPhoto
        self.likedMatches = likedMatches
        self.lookingFor = lookingFor
        self.biography = biography
        self.matches = matches
        self.userUID = userUID
        self.maxDistance = maxDistance
        
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
        let age = try container.decode(String.self, forKey: .ageKey)
        let genderString = try container.decode(String.self, forKey: .genderKey)
        let zip = try container.decode(String.self, forKey: .zipcodeKey)
        let conditionString = try container.decode([String].self, forKey: .conditionKey)
        let mainPhotoString = try container.decode(String.self, forKey: .mainPhotoKey)
        let lookingForString = try container.decode([String].self, forKey: .lookingForKey)
        let bio = try container.decode(String.self, forKey: .biographyKey)
        let userID = try container.decode(String.self, forKey: .userUIDKey)
        let maxD = try container.decode(String.self, forKey: .maxDistanceKey)
       
        
        self.likedMatches = likedContainer
        self.matches = matchesContainer
        self.firstName = first
        self.lastName = last
        self.email = emailAddress
        self.age =  Int(age)!
        self.gender = genderString
        self.zipcode = Int(zip)!
        self.condition = conditionString
        self.mainPhoto = URL(fileURLWithPath: mainPhotoString)
        self.lookingFor = lookingForString
        self.biography = bio
        self.userUID = userID
        self.maxDistance = Int(maxD)!
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
