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
    var email: String?
    var dob: Date?
    var zipcode: Int?
    var biography: String?
    
    let genderChoice = ["Female",
                  "Male",
                  "Trans",
                  "Non-binary",
                  "Questioning",
                  "Other"]
    
    let ageChoice = ["18", "19", "20", "21", "22", "23", "24", "25", "26", "27", "28", "29", "30", "31", "32", "33", "34", "35", "36", "37", "38", "39", "40", "41", "42", "43", "44", "45", "46", "47", "48", "49", "50", "51", "52", "53", "54", "55", "56", "57", "58", "59", "60"]
    
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
    @IBOutlet weak var bioLabel: UILabel!
    
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var headerView: UIView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButton(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text,
            let gender = genderTextField.text,
            let dob = dateOfBirthTextField.text,
            let zipcode = zipTextField.text,
            let biography = bioTextField.text else { return }
        
        self.firstName = firstName
        self.lastName = lastName
        self.gender = gender
        self.zipcode = Int(zipcode)
        self.biography = biography
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM/dd/yyyy"
        let date = dateFormatter.date(from: dob)!
        self.dob = date
        
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "SaveGetInfo", sender: self)
        }
    }
    
    func createGenderPicker() {
        let genderPicker = UIPickerView()
        genderPicker.delegate = self as! UIPickerViewDelegate
        genderTextField.inputView = genderPicker
        
        //Customizations
        //genderPicker.backgroundColor = .white
        
    }
    
    func createAgePicker() {
        let agePicker = UIPickerView()
        agePicker.delegate = self as! UIPickerViewDelegate
        dateOfBirthTextField.inputView = agePicker
        
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
        createAgePicker()
        createToolbar()
        setTheme()
        
        //date picker
//        datePicker = UIDatePicker()
//        datePicker?.datePickerMode = .date
//        datePicker?.addTarget(self, action: #selector(GetUserInfoViewController.dateChanged(datePicker:)), for: .valueChanged)
//
//
//        dateOfBirthTextField.inputView = datePicker
    }
    
//    @objc func dateChanged(datePicker: UIDatePicker) {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "MM dd, yyyy"
//        dateFormatter.dateStyle = .short
//
//        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
//        //view.endEditing(true)
//
//    }
    
    private func setTheme() {
        firstNameTextField.setPadding()
        lastNameTextField.setPadding()
        genderTextField.setPadding()
        dateOfBirthTextField.setPadding()
        zipTextField.setPadding()
        bioTextField.setPadding()
        
        firstNameTextField.textColor = .grape
        lastNameTextField.textColor = .grape
        genderTextField.textColor = .grape
        dateOfBirthTextField.textColor = .grape
        zipTextField.textColor = .grape
        bioTextField.textColor = .grape
        
        headerView.backgroundColor = .violet
        

        firstNameTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        lastNameTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        genderTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        dateOfBirthTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        zipTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        bioTextField.backgroundColor = UIColor.grape.withAlphaComponent(0.1)
        
        view.backgroundColor = .violet
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveGetInfo" {
            guard let destination = segue.destination as? BioConditionViewController else { return }
            
            destination.firstName = self.firstName
            destination.lastName = self.lastName
            destination.gender = self.gender
            destination.dob = self.dob
            destination.zipcode = self.zipcode
            destination.biography = self.biography
            destination.email = self.email
            
            destination.currentUserUID = self.currentUserUID
            destination.user2Controller = user2Controller
            
        }
    }
}

extension GetUserInfoViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == genderTextField {
            return genderChoice.count
        } else {
            return ageChoice.count
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == genderTextField {
            return genderChoice[row]
        } else {
            return ageChoice[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == genderTextField {
            genderTextField.text = genderChoice[row]
            //genderTextField.text = selectedGender
        } else if pickerView == dateOfBirthTextField {
            dateOfBirthTextField.text = ageChoice[row]
        }
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
