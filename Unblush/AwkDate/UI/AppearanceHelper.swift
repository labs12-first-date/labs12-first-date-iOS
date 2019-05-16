//
//  Appearance.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/14/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

enum AppearanceHelper {
    
    //allows for accomodating large type
    static func boldFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica Neue Bold", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .caption1).scaledFont(for: font)
    }
    
    static func mediumFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica Neue", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    
    static func lightFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica Neue Light", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    
    static func Appearance() {
        //navigationbar
        UINavigationBar.appearance().barTintColor = .violet
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.grape]
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        UITextField.appearance().tintColor = .grape
        
        //UITextView.appearance().tintColor = .none
        
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.grape, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 30)!]
        
        //bar button item
        UIBarButtonItem.appearance().tintColor = .grape
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.grape], for: .normal)
        
        //labels
        UILabel.appearance().textColor = .grass
        UILabel.appearance().font = UIFont(name: "Helvetica Neue", size: 16)
    }
    
    static func style(button: UIButton) {
        button.titleLabel?.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        button.titleLabel?.adjustsFontForContentSizeCategory = true
        
        button.setTitleColor(.grape, for: .normal)
        //button.backgroundColor = .midnight
        //button.layer.cornerRadius = 8
    }
}
