//
//  LikedCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class LikedCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var profile: [String:Any]?
    var photo: UIImage?
    var userController: User2Controller?
    
    //MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBAction func chatButton(_ sender: Any) {
    
    }
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.textColor = .cream
        nameLabel.font = AppearanceHelper.mediumFont(with: .subheadline, pointSize: 25)
        ageLabel.textColor = .mustard
        ageLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        locationLabel.textColor = .mustard
        locationLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        bioLabel.textColor = .mustard
        bioLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        
        photoView.layer.cornerRadius = photoView.frame.size.width / 2
        photoView.clipsToBounds = true
    }
    
    
    
   /* func updateViews() {
        guard let photo = photo else { return }
        photoView.image = photo
        nameLabel.text = profile?.firstName
        ageLabel.text = "\(profile?.age))"
        locationLabel.text = "\(profile?.zipcode)"
        bioLabel.text = profile?.biography
    }*/
}
