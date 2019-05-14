//
//  ColorConvenience.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/14/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init (_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat, _ alpha: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
    
    static let violet = UIColor(48, 10, 74, 1)
    static let midnight = UIColor(13, 1, 52, 1)
    static let grape = UIColor(182, 18, 209, 1)
    static let water = UIColor(27, 60, 216, 1)
    static let grass = UIColor(4, 191, 104, 1)
}
