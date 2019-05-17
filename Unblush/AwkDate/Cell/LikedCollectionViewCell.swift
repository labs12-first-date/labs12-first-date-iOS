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
    var profile: Profile?
    var photo: UIImage?
    
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
        setTheme()
        //updateViews()
    }
    
    func setTheme() {
        AppearanceHelper.style(button: chatButton)
        
    }
    
//    func updateViews() {
//        guard let photo = photo else { return }
//        photoView.image = photo
//        nameLabel.text = profile?.firstName
//        ageLabel.text = "\(profile?.age))"
//        locationLabel.text = "\(profile?.zipcode)"
//        bioLabel.text = profile?.biography
//    }
}
