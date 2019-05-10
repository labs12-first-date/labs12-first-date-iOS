//
//  GetUserInfoViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class GetUserInfoViewController: UIViewController {
    
    //MARK: - Properties
    var user2Controller: User2Controller?
    var currentUserUID: String?
    var profile: Profile?
    
    private var datePicker: UIDatePicker?
    
    var firstName: String?
    var lastName: String?
    var gender: String?
    var dob: String?
    var zipcode: Int?
    
    let genderChoice = ["Female",
                  "Male",
                  "Trans",
                  "Non-binary",
                  "Questioning",
                  "Other"]
    
    var selectedGender: String?
    
    //MARK: - Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderTextField: UITextField!
    
    @IBOutlet weak var laterButton: UIButton!
    @IBAction func laterButton(_ sender: Any) {
        performSegue(withIdentifier: "later", sender: self)
    }
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButton(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text,
            let gender = genderTextField.text,
            let dob = dateOfBirthTextField.text,
            let zipcode = zipTextField.text else { return }
        
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.dob = dob
        self.zipcode = Int(zipcode)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: dob)!
        
    }
    
    func createGenderPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self as! UIPickerViewDelegate
        genderTextField.inputView = genderPicker
        
        //Customizations
        //genderPicker.backgroundColor = .white
        
    }
    
    func createToolbar() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(GetUserInfoViewController.dismissKeyboard))
        
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        genderTextField.inputAccessoryView = toolBar
        dateOfBirthTextField.inputAccessoryView = toolBar
        
        //Customization
        //toolBar.barTintColor = .black
        //toolBar.tintColor = .white
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGenderPicker()
        createToolbar()
        
        //date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(GetUserInfoViewController.dateChanged(datePicker:)), for: .valueChanged)
        
//        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GetUserInfoViewController.viewTapped(gestureRecognizer:)))
        
//        tapGesture.cancelsTouchesInView = false
//        view.addGestureRecognizer(tapGesture)
        
        dateOfBirthTextField.inputView = datePicker
    }
    
//    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
//        view.endEditing(true)
//    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"
        
        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
        //view.endEditing(true)
        
    }
    
//    private func updateViews() {
//        guard isViewLoaded else { return }
//        guard let profile = profile
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveGetInfo" {
            guard let destination = segue.destination as? BioConditionViewController else { return }
            
            destination.firstName = self.firstName
            destination.lastName = self.lastName
            destination.gender = self.gender
            destination.dob = self.dob
            destination.zipcode = self.zipcode
        }
    }
}

extension GetUserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genderChoice.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return genderChoice[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedGender = genderChoice[row]
        genderTextField.text = selectedGender
    }
    
//    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
//        var label: UILabel
//
//        if let view = view as? UILabel {
//            label = view
//        } else {
//            label = UILabel()
//        }
//
//        label.textColor = .white
//        label.textAlignment = .center
//        label.font = UIFont(name: "Menlo-Regular", size: 17)
//
//        label.text = genderChoice[row]
//        return label
//    }
    
}
