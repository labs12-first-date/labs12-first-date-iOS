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
    
        return [Onboarding(title: "This is a test for 1", color: .violet),
                Onboarding(title: "This is a test for 2", color: .midnight),
                Onboarding(title: "This is a test for 3", color: .violet)
        ]
    }
}
