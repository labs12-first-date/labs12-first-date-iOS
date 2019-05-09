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
    var profile: Profile?
    private var datePicker: UIDatePicker?
    
    //MARK: - Outlets
    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var dateOfBirthTextField: UITextField!
    @IBOutlet weak var zipLabel: UILabel!
    @IBOutlet weak var zipTextField: UITextField!
    
    @IBOutlet weak var laterButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func saveButton(_ sender: Any) {
        guard let firstName = firstNameTextField.text, !firstName.isEmpty,
            let lastName = lastNameTextField.text,
            let dob = dateOfBirthTextField.text,
            let zipcode = zipTextField.text else { return }
        
        let date = self.dateFormatter.date(from: dob)!
        
//        if let user = user {
        //need to use create profile            user2Controller.createProfile(.....
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
    
    private func updateViews() {
        guard isViewLoaded else { return }
        guard let profile = profile
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SaveGetInfo" {
            guard segue.destination is BioConditionViewController else { return }
        }
    }
    
}

