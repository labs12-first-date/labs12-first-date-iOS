//
//  BogusMatchCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BogusMatchCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var matchImageView: UIImageView!
    
    @IBOutlet weak var matchNameLabel: UILabel!
    
    @IBOutlet weak var matchAgeLabel: UILabel!
    
    @IBOutlet weak var matchLocationLabel: UILabel!
    
    @IBOutlet weak var matchBioLabel: UILabel!
    
    @IBOutlet weak var dontLikeButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBAction func dontLikeButtonTapped(_ sender: UIButton) {
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
    }
    
    
}
