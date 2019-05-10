//
//  ProfileViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - Properties
    var user2Controller: User2Controller?
    var currentUserUID: String?
    var profile: Profile?
    
    private var profileImage: UIImage? {
        didSet {
            updateImage()
        }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var notLikeButton: UIButton!
    @IBAction func notLikeButton(_ sender: Any) {
        
    }
    @IBOutlet weak var likeButton: UIButton!
    @IBAction func likeButton(_ sender: Any) {
        
    }
    @IBOutlet weak var matchesButton: UIBarButtonItem!
    @IBAction func matchesButton(_ sender: Any) {
        
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var addPhoto: UIButton!
    @IBAction func addPhoto(_ sender: Any) {
        presentImagePickerController()

    }
    @IBOutlet weak var messageButton: UIButton!
    @IBAction func messageButton(_ sender: Any) {
        performSegue(withIdentifier: "messages", sender: self)

    }
    @IBOutlet weak var mediaButton: UIButton!
    @IBAction func mediaButton(_ sender: Any) {
        performSegue(withIdentifier: "media", sender: self)

    }
    @IBOutlet weak var settingsButton: UIButton!
    @IBAction func settingsButton(_ sender: Any) {
        performSegue(withIdentifier: "settings", sender: self)

    }
    @IBOutlet weak var editButton: UIButton!
    @IBAction func editButton(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            NSLog("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func updateImage() {
        if let profileImage = profileImage {
            addPhoto.isHidden = true
        } else {
            profileView.image = nil
        }
    }
}
