//
//  BioConditionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ConditionLookingForViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
    var lookingFor: [String] = []
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    let conditions: [ConditionType] = [.aids, .chlamydia, .crabs, .genitalWarts, .gonorrhea, .hepB, .hepC, .hepD, .herpes, .hiv, .syphyllis, .theClap]
    
    let lookingForCriteria: [LookingForType] = [.sameGender, .sameCondition, .openToAllPossibilities, .openToAllConditions, .fiveYearAgeGap, .tenYearAgeGap, .threeYearAgeGap]
    
    //MARK: - Outlets
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var conditionsTableView: UITableView!
    
    @IBOutlet weak var addButton: UIButton! 
    
    @IBAction func addButton(_ sender: Any) {
        presentImagePickerController()
    }
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var lookingTableView: UITableView!
    
    @IBOutlet weak var photoView: UIImageView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var count: Int?
        
        if tableView == self.conditionsTableView {
            count = conditions.count
        }
        
        if tableView == self.lookingTableView {
            count = lookingForCriteria.count
        }
        
        return count!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //var cell: UITableViewCell?
        if tableView == conditionsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell", for: indexPath) as! CondTableViewCell
            
            let condition = conditions[indexPath.row]
            cell.conditionNameLabel.text = condition.rawValue
            cell.condition = condition
            style(cell: cell)
            return cell
            
        } else {
            //tableView == lookingTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LookingForCell", for: indexPath) as! LookingForTableViewCell
                
                let lookingFor = lookingForCriteria[indexPath.row]
                cell.lookingForLabel.text = lookingFor.rawValue
                cell.lookingFor = lookingFor
                style(cell: cell)
                return cell
          
        }
    }
        
        func style(cell: UITableViewCell) {
            //cell.textLabel?.font = AppearanceHelper.typerighterFont(with: .caption1, pointSize: 30)
            cell.textLabel?.adjustsFontForContentSizeCategory = true
            //cell.detailTextLabel?.font = AppearanceHelper.typerighterFont(with: .caption2, pointSize: 25)
            cell.detailTextLabel?.adjustsFontForContentSizeCategory = true
            
            cell.textLabel?.backgroundColor = .clear
            cell.detailTextLabel?.backgroundColor = .clear
            
            cell.textLabel?.textColor = .grape
            cell.detailTextLabel?.textColor = .grape
            //this makes the white background go away in the back, or cell.selectionStyle = .none
            cell.selectionStyle = UITableViewCell.SelectionStyle.none
            cell.backgroundColor = .violet
        }
        
        @IBAction func saveButton(_ sender: Any) {
            guard let photo = photoView.image, let photoData = photo.pngData() else { return }
            
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
            
            
            user2Controller!.uploadPhoto(imageContainer: photoData)
            
            if user2Controller?.currentPhoto != nil {
                
                user2Controller?.putProfileToServer(userID: currentUserUID!, firstName: firstName!, lastName: lastName!, email: email!, age: age!, gender: gender!, zipcode: zipcode!, condition: conditionsFromTableView, mainPhoto: nil, lookingFor: lookingForFromTableView, biography: biography!, completion: { (error) in
                    
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
        
        override func viewDidLoad() {
            super.viewDidLoad()
            setNeedsStatusBarAppearanceUpdate()
            //setUpPhotoView()
            setTheme()
        }
        
        func setTheme() {
            AppearanceHelper.style(button: addButton)
            conditionsTableView.separatorColor = .grape
            lookingTableView.separatorColor = .grape
            
            conditionLabel.textColor = .grass
            lookingForLabel.textColor = .grass
            
            conditionLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
            lookingForLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
            
            view.backgroundColor = .violet
        }
        
        //    private func updateImage() {
        //        if let scaledImage = scaledImage {
        //            addButton.isHidden = true
        //            photoView.image = scaledImage
        //        } else {
        //            photoView.image = nil
        //        }
        //    }
        
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
        
        //    private func setUpPhotoView() {
        //        photoView.layer.cornerRadius = photoView.frame.width / 2
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
