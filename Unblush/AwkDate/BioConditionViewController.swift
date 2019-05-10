//
//  BioConditionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class BioConditionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //MARK: - Properties
    var user2Controller: User2Controller?
    var currentUserUID: String?
    var profile: Profile?
        
    var firstName: String?
    var lastName: String?
    var gender: String?
    var dob: String?
    var zipcode: Int?
    var biography: String?
    var condition: [String]
    
    let STDS = ["AIDS",
                "HIV",
                "Herpes",
                "Chlamydia",
                "The Clap",
                "Hep C",
                "Hep B",
                "Hep D",
                "Genital Warts",
                "Crabs",
                "Gonorrhea",
                "Syphyllis"
    ]
    
    //MARK: - Outlets
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioTextField: UITextField!
    
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBAction func saveButton(_ sender: Any) {
        guard let biography = bioTextField.text else { return }
        
        self.biography = biography
    }
    
    @IBOutlet weak var fillLaterButton: UIButton!
    @IBAction func fillLaterButton(_ sender: Any) {
        performSegue(withIdentifier: "fillLater", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
        tableView.dataSource = self
        tableView.delegate = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return STDS.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conditionCell", for: indexPath)
        
        cell.textLabel?.text = STDS[indexPath.row]
        
        return cell
    }
    
    //            user2Controller?.putProfileToServer(userID: <#T##String#>, firstName: <#T##String#>, lastName: <#T##String#>, email: <#T##String#>, dob: <#T##Date#>, gender: <#T##String#>, zipcode: <#T##Int#>, condition: <#T##[String]#>, mainPhoto: <#T##Data#>, lookingFor: <#T##String#>, biography: <#T##String#>)
    //
    //        }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            guard let destination = segue.destination as? ProfileViewController else { return }
            
            
        }
    }
}
