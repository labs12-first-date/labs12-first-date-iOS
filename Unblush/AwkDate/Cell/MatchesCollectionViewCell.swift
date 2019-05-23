//
//  MatchesCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Properties
    var profile: [String:Any]?
    var photo: UIImage?
    var userController: User2Controller?
    
    //MARK: - Outlets
    @IBOutlet weak var donotLikeButton: UIButton!
    @IBAction func donotLikeButton(_ sender: Any) {
        guard let profile = profile else { return }
        let index = filteredProfiles.firstIndex(where: { $0["email"] as! String == profile["email"] as! String })
        DispatchQueue.main.async {
            self.donotLikeButton.setTitle("Disliked!", for: .normal)
            self.likeButton.alpha = 0
            self.donotLikeButton.setTitleColor(.red, for: .normal)
        }
        
        // we need a property to store disliked matches
        userController?.updateDisLikedMatchesOnServer(userUID: self.userController!.currentUserUID!, dislikedMatch: profile, completion: { (error) in
            if let error = error {
                print("error in table view cell disliked matches: \(error)")
                return
            }
            filteredProfiles.remove(at: index!)
            NotificationCenter.default.post(name: .updateCollection, object: nil)
        })
    }
    
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButton(_ sender: Any) {
        
        guard let profile = profile else { return }
        let index = filteredProfiles.firstIndex(where: { $0["email"] as! String == profile["email"] as! String })
        DispatchQueue.main.async {
            self.likeButton.setTitle("Liked!", for: .normal)
            self.donotLikeButton.alpha = 0
            self.likeButton.setTitleColor(.red, for: .normal)
        }
        /*  let ageString = self.userController?.singleProfileFromServer["age"] as! String
         let zipString = self.userController?.singleProfileFromServer["zip_code"] as! String*/
        
        userController?.updateLikedMatchesOnServer(userUID: self.userController!.currentUserUID!, likedMatch: profile, completion: { (error) in
            if let error = error {
                print("error in table view cell liked matches: \(error)")
                return
            }
            filteredProfiles.remove(at: index!)
            NotificationCenter.default.post(name: .updateCollection, object: nil)
        })
    }
    
    @IBOutlet weak var photoView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.textColor = .grass
        nameLabel.font = AppearanceHelper.mediumFont(with: .subheadline, pointSize: 25)
        ageLabel.textColor = .violet
        ageLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 17)
        locationLabel.textColor = .violet
        locationLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 17)
        bioLabel.textColor = .violet
        bioLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 17)
        
//        photoView.layer.cornerRadius = photoView.frame.size.width / 2
//        photoView.clipsToBounds = true
        
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

extension Notification.Name {
    static let updateCollection = Notification.Name("update")
}
