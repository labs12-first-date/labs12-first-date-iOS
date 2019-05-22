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
    
    var newAgeGap: String?
    var newGender: String?
    var newZipcode: String?
    var newDistance: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.zipcodeTextField.delegate = self
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
        
        zipcodeTextField.placeholder = currentLocation
        genderPickerViewTextField.text = currentGender
        distanceSlider.value = Float(Int(currentMaxDistance!)!)
        
        let lookingForArray = userController?.singleProfileFromServer["looking_for"] as! [String]
        
        for look in lookingForArray {
            if LookingForType(rawValue: look) == LookingForType.fiveYearAgeGap {
                ageRangePickerViewTextField.text = look
                self.currentAgeGap = look
            } else if LookingForType(rawValue: look) == LookingForType.threeYearAgeGap {
                ageRangePickerViewTextField.text = look
                self.currentAgeGap = look
            } else if LookingForType(rawValue: look) == LookingForType.tenYearAgeGap {
                ageRangePickerViewTextField.text = look
                self.currentAgeGap = look
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
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(BogusSettingsViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        genderPickerViewTextField.inputAccessoryView = toolBar
        ageRangePickerViewTextField.inputAccessoryView = toolBar
        
        //Customization
        //toolBar.barTintColor = .black
        //toolBar.tintColor = .white
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    
    func createGenderPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self as! UIPickerViewDelegate
        genderPickerViewTextField.inputView = genderPicker
        
        //Customizations
        //genderPicker.backgroundColor = .white
        
    }
    
    func createAgePicker() {
        let agePicker = UIPickerView()
        agePicker.delegate = self as! UIPickerViewDelegate
        ageRangePickerViewTextField.inputView = agePicker
        
        //Customizations
        //genderPicker.backgroundColor = .white
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if zipcodeTextField.text == currentLocation {
            print("No change in location")
            return
        }
        
        if zipcodeTextField.text != currentLocation {
            //zipcodeTextField.resignFirstResponder()
            saveButton.isEnabled = true
            saveButton.tintColor = UIColor.white.withAlphaComponent(1)
            newZipcode = zipcodeTextField.text
        }
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        if zipcodeTextField.text == currentLocation {
            print("No change in location")
            return
        } else if zipcodeTextField.text != currentLocation {
            saveButton.isEnabled = true
            saveButton.tintColor = UIColor.white.withAlphaComponent(1)
            newZipcode = zipcodeTextField.text
        }
        
    }
    
    
    // slider or text field to enter mileage distance
    // slider with (3, 5, 10) age gap or buttons labeled 3, 5, 10 or enum w/table view
    
    // change password
    // change location
    //
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        if saveButton.isEnabled == true {
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
            
            if newGender != nil {
                // update document
                userController?.updateGenderOnServer(userUID: userController!.serverCurrentUser!.uid, gender: newGender!, completion: { (error) in
                    if let error = error {
                        print("Error updating gender in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated gender on profile!")
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
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated age gap on profile!")
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
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated max distance on profile!")
                        self.newDistance = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                    }
                })
            }
            if newZipcode != nil && newZipcode != currentLocation {
                userController?.updateZipcodeOnServer(userUID: userController!.serverCurrentUser!.uid, zipcode: newZipcode!, completion: { (error) in
                    if let error = error {
                        print("Error updating zipcode in vc: \(error)")
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.displayMessage(userMessage: error.localizedDescription)
                    }
                    
                    DispatchQueue.main.async {
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        self.successDisplayMessage(userMessage: "Successfully updated zipcode on profile!")
                        self.newZipcode = nil
                        self.saveButton.isEnabled = false
                        self.saveButton.tintColor = UIColor.white.withAlphaComponent(0)
                    }
                })
            }
        }
    }
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func changePasswordTapped(_ sender: UIButton) {
        if let oldPw = currentPasswordTextField.text, let newPw = newPasswordTextField.text, let confirmPw = confirmPasswordTextField.text {
            
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
        saveButton.isEnabled = true
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
                            self.dismiss(animated: true, completion: nil)
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
                            self.dismiss(animated: true, completion: nil)
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

}

