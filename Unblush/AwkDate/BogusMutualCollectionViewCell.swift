//
//  BogusMutualCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/16/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BogusMutualCollectionViewCell: UICollectionViewCell {
    
    var profile: [String:Any]? {
        didSet {
            
        }
    }
    
    var userController: User2Controller?
    
    
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var chatButton: UIButton!
    
    @IBAction func chatButtonTapped(_ sender: UIButton) {
        
        // create channel
       

    }
    
    
}
