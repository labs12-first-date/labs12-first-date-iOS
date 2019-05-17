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
    
    //MARK: - Outlets
    @IBOutlet weak var matchesButton: UIBarButtonItem!
    @IBAction func matchesButton(_ sender: Any) {
        
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var profileView: UIImageView!
   
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
    
    var photo: UIImage?
    
    func updateViews() {
        guard let photo = photo else { return }
        
        profileView.image = photo
        navigationItem.title = profile?.firstName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //setUpPhotoView()
        setTheme()
        
        user2Controller?.fetchProfileFromServer(userID: currentUserUID!, completion: { (error) in
            if let error = error {
                print("Error fetching profile in profile vc: \(error)")
                return
            }
            let photoData = self.load(fileName: self.user2Controller?.singleProfileFromServer["profile_picture"] as! String)
            self.nameLabel.text = (self.user2Controller?.singleProfileFromServer["first_name"] as! String)
            
            self.photo = photoData
            DispatchQueue.main.async {
                self.updateViews()
            }
        })
    }
    
    func setTheme() {
        AppearanceHelper.style(button: messageButton)
        AppearanceHelper.style(button: mediaButton)
        AppearanceHelper.style(button: settingsButton)
        AppearanceHelper.style(button: editButton)
        
        view.backgroundColor = .violet
        
    }
    
//    private func setUpPhotoView() {
//        profileView.layer.cornerRadius = profileView.frame.width / 2
//    }
    
    private func load(fileName: String) -> UIImage? {
        print("file name: \(fileName)")
        let url = NSURL(string: fileName)
        let newURL = NSURL(string: fileName)
        
        let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        do {
            let imageData = try Data(contentsOf: newURL! as URL)
            print("Image data: \(imageData)")
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }

}
