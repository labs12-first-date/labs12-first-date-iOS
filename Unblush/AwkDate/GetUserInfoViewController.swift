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
        
//        if let profile = profile {
//            user2Controller?.putProfileToServer(userID: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, dob: <#T##Date#>, gender: <#T##String#>, zipcode: <#T##Int#>, condition: <#T##[String]#>, mainPhoto: <#T##Data#>, lookingFor: <#T##String#>, biography: <#T##String#>)
//        
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //date picker
        datePicker = UIDatePicker()
        datePicker?.datePickerMode = .date
        datePicker?.addTarget(self, action: #selector(GetUserInfoViewController.dateChanged(datePicker:)), for: .valueChanged)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GetUserInfoViewController.viewTapped(gestureRecognizer:)))
        
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
        
        dateOfBirthTextField.inputView = datePicker
    }
    
    @objc func viewTapped(gestureRecognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    @objc func dateChanged(datePicker: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM dd, yyyy"
        
        dateOfBirthTextField.text = dateFormatter.string(from: datePicker.date)
        view.endEditing(true)
        
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

