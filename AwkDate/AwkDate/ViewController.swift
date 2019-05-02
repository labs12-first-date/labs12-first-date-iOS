//
//  ViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 4/30/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        // Do any additional setup after loading the view.
    }

    let userController = UserController()
    var photo: Photo?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBAction func addPhotoTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func updateViews() {
        guard let photo = photo else { return }
        
        imageView.image = UIImage(data: photo.imageData)
    }
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        guard let photoView = imageView.image, let photoData = photoView.pngData() else { return }
        
        print("Photo present!")
        
        userController.uploadPhoto(imageContainer: photoData, caption: "Main Photo")
        if userController.currentPhoto != nil {
            
            userController.createUserAccount(withEmail: "test6@test.com", andPassword: "testtest4", andFirst: "Jill", andLast: "Blue", age: 20, gender: "Male", mainPhoto: photoData, zipcode: 22191, biography: "Yo", condition: [STD(title: "HIV")]) { (error) in
                if let error = error {
                    print("Error creating user account: \(error)")
                    return
                }
                print("Successfully created user account!")
            }
            
        }
        imageView.image = nil
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let original = info[.originalImage] as? UIImage else { return }
        //imageView.contentMode = .scaleAspectFit
        imageView.image = original
        
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    
}

