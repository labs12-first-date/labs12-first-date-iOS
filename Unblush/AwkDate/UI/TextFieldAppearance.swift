//
//  TextFieldAppearance.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/14/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
        //self.layer.backgroundColor = UIColor.violet.cgColor

    }
}
