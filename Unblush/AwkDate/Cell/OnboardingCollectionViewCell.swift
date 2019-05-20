//
//  OnboardingCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/14/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var backgroundColorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    //MARK: - Properties
    var onboarding: Onboarding? {
        didSet {
            self.updateUI()
        }
    }
    
    private func updateUI() {
        if let onboarding = onboarding {
            titleLabel.text = onboarding.title
            backgroundColorView.backgroundColor = onboarding.color
            
            backgroundColorView.layer.cornerRadius = 10.0
            backgroundColorView.layer.masksToBounds = true
        } else {
            titleLabel.text = nil
            backgroundColorView.backgroundColor = nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 3.0
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.2
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        self.clipsToBounds = false
    }
}
