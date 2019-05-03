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
            
            
            userController.createUserAccount(withEmail: "test5@test.com", andPassword: "testtest9", andFirst: "Black", andLast: "Widow", age: 30, gender: "Female", mainPhoto: photoData, zipcode: 22191, biography: "superhero", condition: ["HIV", "Herpes"]) { (error) in
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

/*
 let user = User(email: "test8@test.com", password: "testtest8", identifier: "idjgueka", firstName: "Joe", lastName: "Black", age: 18, gender: "Male", mainPhoto: userController.currentPhoto!, zipcode: 22191, biography: "Hello", condition: [STD(title: "HIV")], likedMatches: [], message: [], photoLibrary: [])
 
 userController.putUserToServer(user: user) { (error) in
 if let error = error {
 print("Error in save photo: \(error)")
 return
 }
 print("Put to Server!")
 }*/
