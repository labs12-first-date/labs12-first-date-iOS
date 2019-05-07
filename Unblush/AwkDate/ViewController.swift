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

   // let userController = UserController()
    let user2Controller = User2Controller()
    var photo: Data?
    
    
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
        
        imageView.image = UIImage(data: photo)
    }
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        guard let photoView = imageView.image, let photoData = photoView.pngData() else { return }
        
        print("Photo present!")
        
        user2Controller.uploadPhoto(imageContainer: photoData)
        
        if user2Controller.currentPhoto != nil {
            
            
            user2Controller.createUserAccount(withEmail: "test2@test.com", andPassword: "testtest2") { (error) in
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
