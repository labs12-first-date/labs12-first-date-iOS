////
////  Model.swift
////  FirstDate
////
////  Created by Lambda_School_Loaner_34 on 4/29/19.
////  Copyright © 2019 Frulwinn. All rights reserved.
////
//
import UIKit

struct Users {
    var email: String
    var password: String
    var identifier: String
    var firstName: String
    var lastName: String
    var age: Int
    var gender: String
    var mainPhoto: Data
    var zipcode: Int
    var bio: String
    var condition: [STD]
    
    //var biography: String //ask about the difference between bio and biography?
    var likedMatches: [Profile]
    //var message: [messageThread]
    var photoLibary: [Data]

}

struct Profile {

    var identifier: String //Foreign Key
    var name: String
    var age: String
    var zipcode: Int
    var condition: [String]
    var mainPhoto: Data
    var photoLibrary: [Data]?
    var biography: String
    var isLiked: Bool

}

struct STD {
    var title: String
}

