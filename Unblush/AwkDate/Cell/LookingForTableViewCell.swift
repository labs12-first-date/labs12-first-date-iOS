//
//  LookingForTableViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class LookingForTableViewCell: UITableViewCell {
    
    //MARK: - Properties
    var lookingFor: LookingForType? {
        didSet {
            updateViews()
        }
    }
    
    func updateViews() {
        guard let lookingFor = lookingFor else { return }
        
        
        let buttonCheckImage = UIImage(named: "check")!
        let buttonEmptyImage = UIImage(named: "emptyCheck")!
        
        if lookingForFromTableView.contains(lookingFor.rawValue) {
            uncheckButton.setImage(buttonCheckImage, for: .normal)
        } else {
            uncheckButton.setImage(buttonEmptyImage, for: .normal)
        }
        
        lookingForLabel.textColor = .grape
        lookingForLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        //uncheckButton.tintColor = .grape
    }
    
    
    //MARK: - Outlets
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var uncheckButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: UIButton) {
    
    guard let lookingFor = lookingFor else { return }
        
        let currentImage = uncheckButton.currentImage!
        let buttonEmptyImage = UIImage(named: "emptyCheck")!
        let buttonCheckImage = UIImage(named: "check")!
        
        if currentImage.pngData() != buttonEmptyImage.pngData() {
            
            DispatchQueue.main.async {
                self.uncheckButton.setImage(buttonEmptyImage, for: .normal)
            }
            
            // 10 year age gap already has a check mark, why???
            let indexOfLookFor = lookingForFromTableView.firstIndex(of: lookingFor.rawValue)
            lookingForFromTableView.remove(at: indexOfLookFor!)
            print("Current lookingFor 2: \(lookingForFromTableView)")
        } else {
            if lookingFor.rawValue == "Open to all possibilities" && lookingForFromTableView.count > 0 {
                print("You cannot select other options, if you are open to all possibilities")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select other options, if you are open to all possibilities"])
                
            } else if lookingForFromTableView.contains("Open to all possibilities") {
                print("You cannot select other options, if you are open to all possibilities")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select other options, if you are open to all possibilities"])
                
            } else if lookingForFromTableView.contains("Same Condition as Me") && lookingFor.rawValue == "Open to all conditions" {
                print("You cannot select 'Same condition as me' with 'Open to all conditions' selected. Please choose one.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select 'Same condition as me' with 'Open to all conditions' selected. Please choose one."])
                
            } else if lookingForFromTableView.contains("Open to all conditions") && lookingFor.rawValue == "Same Condition as Me" {
                print("You cannot select 'Open to all conditions' with 'Same condition as me' selected. Please choose one.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select 'Open to all conditions' with 'Same condition as me' selected. Please choose one."])
                
            } else if lookingForFromTableView.contains("Only 5 year age gap") && lookingFor.rawValue == "Only 10 year age gap" {
                print("You cannot select more than one age gap.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select more than one age gap."])
                
            }else if lookingForFromTableView.contains("Only 10 year age gap") && lookingFor.rawValue == "Only 5 year age gap" {
                print("You cannot select more than one age gap.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select more than one age gap."])
                
            } else if lookingForFromTableView.contains("Only 3 year age gap") && lookingFor.rawValue == "Only 5 year age gap" {
                print("You cannot select more than one age gap.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select more than one age gap."])
                
            } else if lookingForFromTableView.contains("Only 5 year age gap") && lookingFor.rawValue == "Only 3 year age gap" {
                print("You cannot select more than one age gap.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select more than one age gap."])
                
            } else if lookingForFromTableView.contains("Only 10 year age gap") && lookingFor.rawValue == "Only 3 year age gap" {
                print("You cannot select more than one age gap.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select more than one age gap."])
                
            } else if lookingForFromTableView.contains("Only 3 year age gap") && lookingFor.rawValue == "Only 10 year age gap" {
                print("You cannot select more than one age gap.")
                NotificationCenter.default.post(name: .displayMsg, object: nil, userInfo: ["message": "You cannot select more than one age gap."])
                
            } else {
                DispatchQueue.main.async {
                    self.uncheckButton.setImage(buttonCheckImage, for: .normal)
                }
                lookingForFromTableView.append(lookingFor.rawValue)
                print("Current lookingFor 1: \(lookingForFromTableView)")
            }
            
            
        }
    }
}

var lookingForFromTableView: [String] = []
