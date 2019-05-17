//
//  Onboarding.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/14/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class Onboarding {
    
    //MARK: - Properties
    var title = ""
    var color: UIColor
    
    init(title: String, color: UIColor) {
        self.title = title
        self.color = color
    }
    
    static func fetchInterests() -> [Onboarding] {
    
        return [Onboarding(title: "Welcome to a dating app that provides a safe space for people with special health conditions.", color: UIColor.grape.withAlphaComponent(0.1)),
                Onboarding(title: "You will be matched with people based on age, condition, and location.", color: UIColor.white.withAlphaComponent(0.15)),
                Onboarding(title: "You will only be able to chat with matches that like you back.", color: UIColor.grape.withAlphaComponent(0.1))
        ]
    }
}
