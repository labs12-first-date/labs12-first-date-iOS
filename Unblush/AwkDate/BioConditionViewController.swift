//
//  BioConditionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BioConditionViewController: UIViewController {
    
    //MARK: - Properties
    var user2Controller: User2Controller?
    var currentUserUID: String?
    var profile: Profile?
        
    var firstName: String?
    var lastName: String?
    var gender: String?
    var dob: String?
    var zipcode: Int?
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //            user2Controller?.putProfileToServer(userID: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, dob: <#T##Date#>, gender: <#T##String#>, zipcode: <#T##Int#>, condition: <#T##[String]#>, mainPhoto: <#T##Data#>, lookingFor: <#T##String#>, biography: <#T##String#>)
    //
    //        }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
