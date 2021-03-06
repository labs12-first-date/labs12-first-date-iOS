//
//  BioConditionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

/*
import UIKit

class BioConditionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
   
    
    
    //MARK: - Properties
    var user2Controller: User2Controller?
    var currentUserUID: String?
    var profile: Profile?
        
    var firstName: String?
    var email: String?
    var lastName: String?
    var gender: String?
    var age: Int?
    var zipcode: Int?
    var biography: String?
    var condition: [String] = [] //not sure of []
    var lookingFor: [String] = [LookingForType.fiveYearAgeGap.rawValue, LookingForType.sameCondition.rawValue, LookingForType.sameGender.rawValue]
    
//    private var profileImage: UIImage? {
//        didSet {
//            updateImage()
//        }
//    }
    
    let conditions: [ConditionType] = [.aids, .chlamydia, .crabs, .genitalWarts, .gonorrhea, .hepB, .hepC, .hepD, .herpes, .hiv, .syphyllis, .theClap]
    let lookingFors: [LookingForType] = [.fiveYearAgeGap, .tenYearAgeGap, .threeYearAgeGap, .openToAllConditions, .openToAllPossibilities, .sameCondition, .sameGender]
    
    //MARK: - Outlets
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionsTableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton!
    @IBAction func addButton(_ sender: Any) {
        presentImagePickerController()
    }
    
    @IBOutlet weak var photoView: UIImageView!
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell", for: indexPath) as! CondTableViewCell
        
        let condition = self.conditions[indexPath.row]
        cell.conditionNameLabel.text = condition.rawValue
        
        cell.condition = condition
        
        return cell
    }
    
    @IBAction func saveButton(_ sender: Any) {
        guard let biography = bioTextField.text, let photo = photoView.image, let photoData = photo.pngData() else { return }
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
        myActivityIndicator.style = (UIActivityIndicatorView.Style.gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.view.addSubview(myActivityIndicator)
        }
        
        self.biography = biography
        
        user2Controller!.uploadPhoto(imageContainer: photoData)
        
        if user2Controller?.currentPhoto != nil {
            user2Controller?.putProfileToServer(userID: currentUserUID!, firstName: firstName!, lastName: lastName!, email: email!, age: 26, gender: gender!, zipcode: zipcode!, condition: conditionsFromTableView, mainPhoto: nil, lookingFor: lookingFor, biography: biography, completion: { (error) in
                if let error = error {
                    print("Error putting profile to server: \(error)")
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    return
                }
                
                DispatchQueue.main.async {
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    self.performSegue(withIdentifier: "profile", sender: self)
                }
                
            })
        }
        
    }
    
   /* override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
           self.con
        }
        tableView.dataSource = self
        tableView.delegate = self
        
    }*/

    
    private func presentImagePickerController() {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary) else {
            NSLog("The photo library is not available")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let original = info[.originalImage] as? UIImage else { return }
        //imageView.contentMode = .scaleAspectFit
        photoView.image = original
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
//    private func updateImage() {
//        if let profileImage = profileImage {
//            addPhoto.isHidden = true
//        } else {
//            profileView.image = nil
//        }
//    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            guard let destination = segue.destination as? ProfileViewController else { return }
            
            destination.currentUserUID = self.currentUserUID
            destination.user2Controller = user2Controller
            
        }
    }
}

/*extension BioConditionViewController {
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
}*/
*/
