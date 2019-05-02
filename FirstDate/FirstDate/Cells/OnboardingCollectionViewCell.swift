//
//  OnboardingCollectionViewCell.swift
//  FirstDate
//
//  Created by Lambda_School_Loaner_34 on 5/2/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    private var labels: [UILabel]!
    
    
    //MARK: - Outlets
    @IBOutlet weak var onboardingLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        labels = [onboardingLabel]
    }

}
