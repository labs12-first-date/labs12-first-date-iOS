//
//  BogusSettingsViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/20/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BogusSettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    // slider or text field to enter mileage distance
    // slider with (3, 5, 10) age gap or buttons labeled 3, 5, 10 or enum w/table view
    
    // change password
    // change location
    //
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    }
    
    @IBOutlet weak var currentPasswordTextField: UITextField!
    
    @IBOutlet weak var newPasswordTextField: UITextField!
    
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    @IBAction func changePasswordTapped(_ sender: UIButton) {
    }
    
    @IBOutlet weak var zipcodeTextField: UITextField!
    
    @IBOutlet weak var distanceSlider: UISlider!
    
    @IBAction func distanceSliderMoved(_ sender: UISlider) {
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

}
