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
    var profile: [String:Any]? {
        didSet {
            setTheme()
        }
    }
    var photo: UIImage?
    var userController: User2Controller?
    
    //MARK: - Outlets
    
    @IBOutlet weak var notLikeButton: UIButton!
    @IBAction func notLikeButtonTapped(_ sender: Any) {
        guard let profile = profile else { return }
        let index = filteredProfiles.firstIndex(where: { $0["email"] as! String == profile["email"] as! String })
        DispatchQueue.main.async {
            self.notLikeButton.setTitle("Disliked!", for: .normal)
            self.didLikeButton.alpha = 0
            self.notLikeButton.setTitleColor(.red, for: .normal)
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
    
    @IBOutlet weak var didLikeButton: UIButton!
    @IBAction func didLikeButton(_ sender: Any) {
        guard let profile = profile else { return }
        let index = filteredProfiles.firstIndex(where: { $0["email"] as! String == profile["email"] as! String })
        DispatchQueue.main.async {
            self.didLikeButton.setTitle("Liked!", for: .normal)
            self.notLikeButton.alpha = 0
            self.didLikeButton.setTitleColor(.red, for: .normal)
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
    
    @IBOutlet weak var matchPhotoView: UIImageView!
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var theirAgeLabel: UILabel!
    @IBOutlet weak var zipcodeLabel: UILabel!
    @IBOutlet weak var biographyLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        firstNameLabel.textColor = .cream
        firstNameLabel.font = AppearanceHelper.mediumFont(with: .subheadline, pointSize: 25)
        theirAgeLabel.textColor = .mustard
        theirAgeLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        zipcodeLabel.textColor = .mustard
        zipcodeLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        biographyLabel.textColor = .mustard
        biographyLabel.font = AppearanceHelper.mediumFont(with: .body, pointSize: 16)
        
        matchPhotoView.layer.cornerRadius = matchPhotoView.frame.size.width / 2
        matchPhotoView.clipsToBounds = true
        
    }
    
    func setTheme() {
        guard let profile = profile else { return }
        
        if filteredProfiles.contains(where: { $0["email"] as! String == profile["email"] as! String }) {
            self.didLikeButton.setTitle("Like", for: .normal)
            self.notLikeButton.alpha = 1
            
            self.notLikeButton.setTitle("Dislike", for: .normal)
            self.didLikeButton.alpha = 1
            
           /* AppearanceHelper.style(button: donotLikeButton)
            AppearanceHelper.style(button: likeButton)*/
        } else {
            self.didLikeButton.setTitle("Like", for: .normal)
            self.notLikeButton.alpha = 1
            
            self.notLikeButton.setTitle("Dislike", for: .normal)
            self.didLikeButton.alpha = 1
            
            /*AppearanceHelper.style(button: donotLikeButton)
            AppearanceHelper.style(button: likeButton)*/
        }
        
    }
}

extension Notification.Name {
    static let updateCollection = Notification.Name("update")
    static let displayMsg = Notification.Name("displayMessage")
    static let updateCheck = Notification.Name("updateCheck")
}
