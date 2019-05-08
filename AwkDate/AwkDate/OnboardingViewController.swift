//
//  OnboardingViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/7/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var onboardingLabel: UILabel!
    @IBOutlet weak var getStartedButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Getstarted" {
            guard segue.destination is GetUserInfoViewController else { return }
        }
    }
}
