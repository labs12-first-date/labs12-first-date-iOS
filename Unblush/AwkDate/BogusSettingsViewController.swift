//
//  BogusSettingsViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/20/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BogusSettingsViewController: UIViewController, UITextFieldDelegate {
    
    var userController: User2Controller?
    
    var currentAgeGap: String?
    var currentGender: String?
    var currentLocation: String?
    var currentMaxDistance: String?
    var currentBio: String?
    
    var newAgeGap: String?
    var newGender: String?
    var newZipcode: String?
    var newDistance: Int?
    var newBio: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        
        self.zipcodeTextField.tag = 1
        self.bioTextField.tag = 2
        
        self.zipcodeTextField.delegate = self
        self.bioTextField.delegate = self
        
        distanceSlider.maximumValue = 70
        distanceSlider.minimumValue = 10
        
        saveButton.isEnabled = false
        saveButton.tintColor = UIColor.white.withAlphaComponent(0)
        createGenderPicker()
        createAgePicker()
        createToolbar()
        
        currentGender = userController?.singleProfileFromServer["gender"] as! String
        currentLocation = userController?.singleProfileFromServer["zip_code"] as! String
        currentMaxDistance = userController?.singleProfileFromServer["max_distance"] as! String
        currentBio = userController?.singleProfileFromServer["bio"] as! String
       // currentAgeRange = userController?.singleProfileFromServer[""] as! String
        
        
        bioTextField.attributedPlaceholder = NSAttributedString(string: currentBio!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
        zipcodeTextField.attributedPlaceholder = NSAttributedString(string: currentLocation!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
        genderPickerViewTextField.attributedPlaceholder = NSAttributedString(string: currentGender!, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
        distanceSlider.value = Float(Int(currentMaxDistance!)!)
        sliderNumberLabel.text = "\(Float(Int(currentMaxDistance!)!))"
        
        let lookingForArray = userController?.singleProfileFromServer["looking_for"] as! [String]
        
        for look in lookingForArray {
            if LookingForType(rawValue: look) == LookingForType.fiveYearAgeGap {
               // ageRangePickerViewTextField.text = look
                self.currentAgeGap = look
                ageRangePickerViewTextField.attributedPlaceholder = NSAttributedString(string: look, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
            } else if LookingForType(rawValue: look) == LookingForType.threeYearAgeGap {
               // ageRangePickerViewTextField.text = look
                self.currentAgeGap = look
                ageRangePickerViewTextField.attributedPlaceholder = NSAttributedString(string: look, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
            } else if LookingForType(rawValue: look) == LookingForType.tenYearAgeGap {
               // ageRangePickerViewTextField.text = look
                self.currentAgeGap = look
                ageRangePickerViewTextField.attributedPlaceholder = NSAttributedString(string: look, attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
            } else {
               // ageRangePickerViewTextField.text = "No Age Gap"
                ageRangePickerViewTextField.attributedPlaceholder = NSAttributedString(string: "No Age Gap", attributes: [NSAttributedString.Key.foregroundColor: UIColor.grape])
            }
        }
        
        // Do any additional setup after loading the view.
    }
    
    let genderChoice = ["Female",
                        "Male",
                        "Trans",
                        "Non-binary",
                        "Questioning",
                        "Other"]
    
    let ageChoice: [LookingForType] = [.fiveYearAgeGap, .threeYearAgeGap, .tenYearAgeGap]
    
    func setTheme() {
        AppearanceHelper.style(button: changepwButton)
        
        //Labels
        currentpwLabel.textColor = .grass
        currentpwLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        newpwLabel.textColor = .grass
        newpwLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        confirmpwLabel.textColor = .grass
        confirmpwLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        locationLabel.textColor = .grass
        locationLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        maximumLabel.textColor = .grass
        maximumLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        genderLabel.textColor = .grass
        genderLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        ageLabel.textColor = .grass
        ageLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        bioLabel.textColor = .grass
        bioLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        milesLabel.textColor = .grass
        milesLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 14)
        sliderNumberLabel.textColor = .grass
        sliderNumberLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 14)
        
        //Textfields
        currentpwTextField.setPadding()
        currentpwTextField.textColor = .grape
        currentpwTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        newpwTextField.setPadding()
        newpwTextField.textColor = .grape
        newpwTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        confirmpwTextField.setPadding()
        confirmpwTextField.textColor = .grape
        confirmpwTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        zipcodeTextField.setPadding()
        zipcodeTextField.textColor = .grape
        zipcodeTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        genderTextField.setPadding()
        genderTextField.textColor = .grape
        genderTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        ageTextField.setPadding()
        ageTextField.textColor = .grape
        ageTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        bioTextField.setPadding()
        bioTextField.textColor = .grape
        bioTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        
        distanceSlider.tintColor = .grape
        
        view.backgroundColor = .violet
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BogusSettingsViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        genderPickerViewTextField.inputAccessoryView = toolBar
        ageRangePickerViewTextField.inputAccessoryView = toolBar
        
        //Customization
        toolBar.barTintColor = .violet
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func createGenderPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self as! UIPickerViewDelegate
        genderPickerViewTextField.inputView = genderPicker
        
        //Customizations
        genderPicker.backgroundColor = UIColor.grape.withAlphaComponent(0.2)
        genderPicker.tintColor = .grape
        
    }
    
    func createAgePicker() {
        let agePicker = UIPickerView()
        agePicker.delegate = self as! UIPickerViewDelegate
        ageRangePickerViewTextField.inputView = agePicker
        
        //Customizations
        agePicker.backgroundColor = UIColor.grape.withAlphaComponent(0.2)
        agePicker.tintColor = .grape
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.tag == 1 {
            if zipcodeTextField.text == currentLocation {
                print("No change in location")
                return
            } else if zipcodeTextField.text != currentLocation {
                //zipcodeTextField.resignFirstResponder()
                saveButton.isEnabled = true
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
                newZipcode = zipcodeTextField.text
            }
        }
        
        if textField.tag == 2 {
           if bioTextField.text == currentBio {
                print("No change in bio")
                return
            } else if bioTextField.text != currentBio {
                saveButton.isEnabled = true
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
                newBio = bioTextField.text
            }
        }
        
        
       // newZipcode = zipcodeTextField.text
        newBio = bioTextField.text
        
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if textField.tag == 1 {
            if zipcodeTextField.text == currentLocation {
                print("No change in location")
                return
            } else if zipcodeTextField.text != currentLocation {
                //zipcodeTextField.resignFirstResponder()
                saveButton.isEnabled = true
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
                newZipcode = zipcodeTextField.text
            }
        }
        
        if textField.tag == 2 {
            if bioTextField.text == currentBio {
                print("No change in bio")
                saveButton.isEnabled = true
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
                return
            } else if bioTextField.text != currentBio {
                saveButton.isEnabled = true
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
                newBio = bioTextField.text
            }
        }
        newBio = bioTextField.text
        newZipcode = zipcodeTextField.text
        
    }
    
    
    // slider or text field to enter mileage distance
    // slider with (3, 5, 10) age gap or buttons labeled 3, 5, 10 or enum w/table view
    
    // change password
    // change location
    //
    
    @IBOutlet weak var milesLabel: UILabel!
    @IBOutlet weak var sliderNumberLabel: UILabel!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var currentpwLabel: UILabel!
    @IBOutlet weak var currentpwTextField: UITextField!
    @IBOutlet weak var newpwLabel: UILabel!
    @IBOutlet weak var newpwTextField: UITextField!
    @IBOutlet weak var confirmpwLabel: UILabel!
    @IBOutlet weak var confirmpwTextField: UITextField!
    @IBOutlet weak var locationLabel: UILabel!
   // @IBOutlet weak var locationTextField: UITextField!
    @IBOutlet weak var maximumLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if saveButton.isEnabled == true {
            //Create Activity Indicator
            let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
            myActivityIndicator.style = (UIActivityIndicatorView.Style.whiteLarge)
            
            // Position Activity Indicator in the center of the main view
            myActivityIndicator.center = self.view.center
            
            // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
            myActivityIndicator.hidesWhenStopped = false
            
            // Start Activity Indicator
            myActivityIndicator.startAnimating()
            
            DispatchQueue.main.async {
                self.view.addSubview(myActivityIndicator)
            }
            
            if bioTextField.text != nil && bioTextField.text != currentBio && bioTextField.text != "" {
                if bioTextField.text!.count < 5 {
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: "Please enter a full bio!")
                        return
                    }
                } else {
                newBio = bioTextField.text
                userController?.updateBioOnServer(userUID: userController!.serverCurrentUser!.uid, biography: newBio!, completion: { (error) in
                    if let error = error {
                        print("Error updating bio in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    NotificationCenter.default.post(name: .updateCollection, object: nil)
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated your  profile!")
                        //self.newBio = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                        }
                    })
                }
            }
            if newGender != nil {
                // update document
                userController?.updateGenderOnServer(userUID: userController!.serverCurrentUser!.uid, gender: newGender!, completion: { (error) in
                    if let error = error {
                        print("Error updating gender in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    NotificationCenter.default.post(name: .updateCollection, object: nil)
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated your  profile!")
                        self.newGender = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                    }
                })
                // remove activity indicator upon completion
            }
            if newAgeGap != nil {
                // update document
                userController?.updateAgeRangeOnServer(userUID: userController!.serverCurrentUser!.uid, ageGap: newAgeGap!, completion: { (error) in
                    if let error = error {
                        print("Error updating age gap in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    NotificationCenter.default.post(name: .updateCollection, object: nil)
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated your profile!")
                        self.newAgeGap = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                    }
                })
            }
            if newDistance != Int(currentMaxDistance!) && newDistance != nil {
                // update document
                userController?.updateMaxDistanceOnServer(userUID: userController!.serverCurrentUser!.uid, maxDistance: String(newDistance!), completion: { (error) in
                    if let error = error {
                        print("Error updating max distance in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    NotificationCenter.default.post(name: .updateCollection, object: nil)
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated your profile!")
                        self.newDistance = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                    }
                })
            }
            if zipcodeTextField.text != nil && zipcodeTextField.text != currentLocation && zipcodeTextField.text != "" {
                newZipcode = zipcodeTextField.text!
                if newZipcode!.count != 5 {
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: "Please enter an accurate zipcode!")
                        return
                    }
                } else {
                userController?.updateZipcodeOnServer(userUID: userController!.serverCurrentUser!.uid, zipcode: newZipcode!, completion: { (error) in
                    if let error = error {
                        print("Error updating zipcode in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    
                    NotificationCenter.default.post(name: .updateCollection, object: nil)
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated your profile!")
                       //
                        self.newZipcode = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                        }
                    })
                }
            }
        }
    }
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBOutlet weak var changepwButton: UIButton!
    @IBAction func changePasswordTapped(_ sender: UIButton) {
        if let oldPw = currentPasswordTextField.text, let newPw = newPasswordTextField.text, let confirmPw = confirmPasswordTextField.text {
            
            let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
            myActivityIndicator.style = (UIActivityIndicatorView.Style.whiteLarge)
            
            // Position Activity Indicator in the center of the main view
            myActivityIndicator.center = self.view.center
            
            // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
            myActivityIndicator.hidesWhenStopped = false
            
            // Start Activity Indicator
            myActivityIndicator.startAnimating()
            
            DispatchQueue.main.async {
                self.view.addSubview(myActivityIndicator)
            }
            
            
            if oldPw == newPw {
                // show error
                print("New password cannot be the same as current.")
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                displayMessage(userMessage: "New password cannot be the same as current.")
                return
            } else if newPw != confirmPw {
                // show error
                print("New password does not match confirmed password")
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                displayMessage(userMessage: "New password does not match confirmed password.")
                return
            } else {
                
                userController?.serverCurrentUser?.updatePassword(to: confirmPw, completion: { (error) in
                    if let error = error {
                        print("Error updating password in tapped: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                        return
                    }
                    
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        print("Successfull updated password!")
                        self.successDisplayMessage(userMessage: "Successfully updated password!")
                        self.currentPasswordTextField.text = ""
                        self.confirmPasswordTextField.text = ""
                        self.newPasswordTextField.text = ""
                    }
                    
                })
    
            }
            
        }
        
    }
    
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var distanceSlider: UISlider!
    
    @IBAction func distanceSliderMoved(_ sender: UISlider) {
        newDistance = Int(sender.value)
        print("Current Distance value: \(newDistance)")
        DispatchQueue.main.async {
            self.sliderNumberLabel.text = "\(self.newDistance!)"
            self.saveButton.isEnabled = true
        }
        
    }
    
    
    @IBOutlet weak var genderPickerViewTextField: UITextField!
    
    @IBOutlet weak var ageRangePickerViewTextField: UITextField!
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func displayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Please Try Again", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            alertController.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
    
    func successDisplayMessage(userMessage:String) -> Void {
        DispatchQueue.main.async
            {
                let alertController = UIAlertController(title: "Success!", message: userMessage, preferredStyle: .alert)
                
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action:UIAlertAction!) in
                    // Code in this block will trigger when OK button tapped.
                    print("Ok button tapped")
                    DispatchQueue.main.async
                        {
                            alertController.dismiss(animated: true, completion: nil)
                    }
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion:nil)
        }
    }
}

extension BogusSettingsViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderPickerViewTextField.inputView {
            return genderChoice.count
        } else if pickerView == ageRangePickerViewTextField.inputView {
            return ageChoice.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == ageRangePickerViewTextField.inputView {
            //let titleRow = ageChoice[row]
            return ageChoice[row].rawValue
        } else if pickerView == genderPickerViewTextField.inputView {
            //let titleRow = genderChoice[row]
            return genderChoice[row]
        } else {
            
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == ageRangePickerViewTextField.inputView {
            ageRangePickerViewTextField.text = ageChoice[row].rawValue
            if ageRangePickerViewTextField.text == currentAgeGap {
                print("No change in age gap")
                return
            } else if ageRangePickerViewTextField.text != currentAgeGap {
                saveButton.isEnabled = true
                newAgeGap = ageRangePickerViewTextField.text
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
            }
            //self.view.endEditing(true)
        } else if pickerView == genderPickerViewTextField.inputView {
            genderPickerViewTextField.text = genderChoice[row]
            if genderPickerViewTextField.text == currentGender {
                print("No change in gender")
                return
            } else if genderPickerViewTextField.text != currentGender {
                saveButton.isEnabled = true
                newGender = genderPickerViewTextField.text
                saveButton.tintColor = UIColor.white.withAlphaComponent(1)
            }
            //self.view.endEditing(true)
        }
    }
    //FIX
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label: UILabel
        if let view = view as? UILabel {
            label = view
        } else {
            label = UILabel()
        }
        label.textColor = .grape
        label.textAlignment = .center
        label.font = UIFont(name: "HelveticaNeue-Light", size: 17)
        //label.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        
        if pickerView == ageRangePickerViewTextField.inputView {
            label.text = ageChoice[row].rawValue
        } else if pickerView == genderPickerViewTextField.inputView {
            label.text = genderChoice[row]
        }
        
        return label
    }

}

