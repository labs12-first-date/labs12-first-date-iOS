//
//  Appearance.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/14/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

enum Appearance {
    
    //allows for accomodating large type
    static func boldFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica Neue Bold", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .caption1).scaledFont(for: font)
    }
    
    static func mediumFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica Neue Medium", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    
    static func lightFont(with textStyle: UIFont.TextStyle, pointSize: CGFloat) -> UIFont {
        guard let font = UIFont(name: "Helvetica Neue Light", size: pointSize) else { fatalError("Font is nil. Check the name of the font.") }
        return UIFontMetrics(forTextStyle: .body).scaledFont(for: font)
    }
    
    static func Appearance() {
        //navigationbar
        UINavigationBar.appearance().barTintColor = .white
        
        let textAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
        UINavigationBar.appearance().largeTitleTextAttributes = textAttributes
        UINavigationBar.appearance().titleTextAttributes = textAttributes
        
        //        UITextField.appearance().tintColor = lambdaRed
        //        UITextView.appearance().tintColor = lambdaRed
        
        
        UINavigationBar.appearance().largeTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.gray, NSAttributedString.Key.font: UIFont(name: "Helvetica Neue", size: 30)!]
        
        //bar button item
        UIBarButtonItem.appearance().tintColor = .gray
        UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font : UIFont(name: "Helvetica Neue", size: 14)!, NSAttributedString.Key.foregroundColor : UIColor.gray], for: .normal)
        
        //labels
        UILabel.appearance().textColor = .white
        UILabel.appearance().font = UIFont(name: "Helvetica Neue", size: 16)
    }
}
