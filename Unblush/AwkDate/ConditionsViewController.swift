//
//  ConditionsViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/10/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ConditionsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.conditions.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConditionCell", for: indexPath) as! ConditionTableViewCell
        
        let condition = self.conditions[indexPath.row]
        cell.conditionNameLabel.text = condition.rawValue
        
        cell.condition = condition
        
        return cell
    }
    
    let conditions: [ConditionType] = [.aids, .chlamydia, .crabs, .genitalWarts, .gonorrhea, .hepB, .hepC, .hepD, .herpes, .hiv, .syphyllis, .theClap]
    

    @IBOutlet weak var conditionsTableView: UITableView!
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
