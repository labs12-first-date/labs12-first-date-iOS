//
//  BogusMatchCollectionViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BogusMatchCollectionViewCell: UICollectionViewCell {
    
    var profile: [String: Any]? {
        didSet {
            
        }
    }
    
    var userController: User2Controller?
    
    @IBOutlet weak var matchImageView: UIImageView!
    
    @IBOutlet weak var matchNameLabel: UILabel!
    
    @IBOutlet weak var matchAgeLabel: UILabel!
    
    @IBOutlet weak var matchLocationLabel: UILabel!
    
    @IBOutlet weak var matchBioLabel: UILabel!
    
    @IBOutlet weak var dontLikeButton: UIButton!
    
    @IBOutlet weak var likeButton: UIButton!
    
    @IBOutlet weak var chatButton: UIButton!
    @IBAction func chatButtonTapped(_ sender: UIButton) {
    }
    @IBAction func dontLikeButtonTapped(_ sender: UIButton) {
        guard let profile = profile else { return }
        DispatchQueue.main.async {
            self.dontLikeButton.setTitle("Disliked!", for: .normal)
            self.likeButton.alpha = 0
            self.dontLikeButton.setTitleColor(.red, for: .normal)
        }
        
        // we need a property to store disliked matches
    
        
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        guard let profile = profile else { return }
        DispatchQueue.main.async {
            self.likeButton.setTitle("Liked!", for: .normal)
            self.dontLikeButton.alpha = 0
            self.likeButton.setTitleColor(.red, for: .normal)
        }
      /*  let ageString = self.userController?.singleProfileFromServer["age"] as! String
        let zipString = self.userController?.singleProfileFromServer["zip_code"] as! String*/
        
        userController?.updateLikedMatchesOnServer(userUID: self.userController!.currentUserUID!, likedMatch: profile, completion: { (error) in
            if let error = error {
                print("error in table view cell liked matches: \(error)")
                return
            }
        })
        
        
    }
    
    
}
