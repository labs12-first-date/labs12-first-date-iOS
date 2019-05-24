//
//  ColorConvenience.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/20/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static let violet = UIColor(23, 1, 38, 1)
    static let midnight = UIColor(11, 28, 41, 1)
    static let blueish = UIColor(33, 36, 56, 1)
    static let grape = UIColor(182, 18, 209, 1)
    static let grass = UIColor(4, 191, 104, 1)
    static let tan = UIColor(217, 202, 173, 1)
    static let cream = UIColor(242, 233, 216, 1)
    static let mustard = UIColor(217, 147, 61, 1)
}
