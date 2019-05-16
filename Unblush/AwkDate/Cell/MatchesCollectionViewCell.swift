//
//  MatchesCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var donotLikeButton: UIButton!
    @IBAction func donotLikeButton(_ sender: Any) {
        
    }
    
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButton(_ sender: Any) {
    
    }
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setTheme()
    }
    
    func setTheme() {
        AppearanceHelper.style(button: donotLikeButton)
        AppearanceHelper.style(button: likeButton)
                
    }
}
