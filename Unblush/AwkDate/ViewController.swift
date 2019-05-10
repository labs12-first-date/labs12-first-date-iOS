//
//  ViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 4/30/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
       /* user2Controller.fetchProfileFromServer(userID: "e1bHvaIJhhPvn7En1ftztHNpWls2") { (error) in
            if let error = error {
                print("Error fetching profile in vc: \(error)")
                return
            }
           // let photoData = self.load(fileName: self.user2Controller.singleProfileFromServer["main_photo"] as! String)
            let photoData = self.load(fileName: "https://firebasestorage.googleapis.com/v0/b/awk-dating.appspot.com/o/images%2F083744af-cdab-4c48-b0a7-6f13e484fff0.jpg?alt=media&token=a156f73e-ca3a-4c6b-a261-d5ea1cdc7432")
            self.photo = photoData
            DispatchQueue.main.async {
                self.updateViews()
            }
        }*/
        
        
        updateViews()
        
    }

   // let userController = UserController()
    let user2Controller = User2Controller()
    var photo: UIImage?

    
    @IBOutlet weak var userInfoLabel: UILabel!
    
    @IBAction func fetchUserTapped(_ sender: UIButton) {
        if user2Controller.currentUserUID != nil {
            
            self.user2Controller.fetchProfileFromServer(userID: user2Controller.currentUserUID!) { (error) in
                if let error = error {
                    print("Error fetching profile in vc: \(error)")
                    return
                }
                print(self.user2Controller.singleProfileFromServer["first_name"] as! String)
                DispatchQueue.main.async {
                    self.userInfoLabel.text = self.user2Controller.singleProfileFromServer["first_name"] as! String
                }
                
            }
            
        }
        
    }
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
        
        imageView.image = photo
        //imageView.image = UIImage(data: photo)
    }
    
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    var documentsUrl: URL {
        return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
    }
    
    private func load(fileName: String) -> UIImage? {
        print("file name: \(fileName)")
        let url = NSURL(string: fileName)
       /* let fileURL = URL(fileURLWithPath: fileName)
        print("file url 1: \(fileURL)")
        let url = NSURL(string: fileName)
        print("file url 2: \(url)")
        let imagePath: String = "file:\(url!.path!)" //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        print("Image Path: \(imagePath)")
        // check if the image is stored already
        if FileManager.default.fileExists(atPath: imagePath),
            let imageData: Data = try? Data(contentsOf: imageUrl),
            let image: UIImage = UIImage(data: imageData, scale: UIScreen.main.scale) {
            return image
        }
        print("No photo")
        return nil*/
        
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
    
    
    @IBAction func savePhotoTapped(_ sender: UIButton) {
        guard let photoView = imageView.image, let photoData = photoView.pngData() else { return }
        //let photoUID = UUID().uuidString
        
        print("Photo present!")

      /*  let fileManager = FileManager.default
        
        guard let imageData = photoView.jpegData(compressionQuality: 1.0) else { fatalError("Impossible to read the image") }
        let filename = getDocumentsDirectory().appendingPathComponent("\(photoUID).png")
        try! imageData.write(to: filename.absoluteURL, options: .atomic)
        
        print("About to see if it exists")
        print(fileManager.fileExists(atPath: filename.path))*/
        
        
        user2Controller.uploadPhoto(imageContainer: photoData)
        
        
        if user2Controller.currentPhoto != nil {
            
            
            user2Controller.createUserAccount(withEmail: "test22@test.com", andPassword: "testtest22") { (error) in
                if let error = error {
                    print("Error creating user account: \(error)")
                    return
                }
                print("Successfully created user account!")
            }
            /*user2Controller.login(withEmail: "test9@test.com", andPassword: "testtest9") { (error) in
                if let error = error {
                    print("Error logging in: \(error)")
                    return
                }
                print("Successfully logged in!")
            }*/
            
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





