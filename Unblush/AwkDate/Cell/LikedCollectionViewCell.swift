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
    
    @IBOutlet weak var chatLabel: UILabel!
    @IBAction func startChatTapped(_ sender: Any) {
        //when clicked should go to chat roome
    }
    
    @IBOutlet weak var startChatButton: UIButton!
    @IBOutlet weak var personPhotoView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var theirAgeLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    
  
    override func awakeFromNib() {
        super.awakeFromNib()
        firstNameLabel.textColor = .cream
        firstNameLabel.font = AppearanceHelper.mediumFont(with: .subheadline, pointSize: 25)
        theirAgeLabel.textColor = .violet
        theirAgeLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        zipcodeLabel.textColor = .violet
        zipcodeLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        biographyLabel.textColor = .violet
        biographyLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        chatLabel.textColor = .cream
        chatLabel.font = AppearanceHelper.lightFont(with: .caption1, pointSize: 13)
        
        personPhotoView.layer.cornerRadius = personPhotoView.frame.size.width / 2
        personPhotoView.clipsToBounds = true
    }
}

    
   /* func updateViews() {
        guard let photo = photo else { return }
        photoView.image = photo
        nameLabel.text = profile?.firstName
        ageLabel.text = "\(profile?.age))"
        locationLabel.text = "\(profile?.zipcode)"
        bioLabel.text = profile?.biography
    }*/
