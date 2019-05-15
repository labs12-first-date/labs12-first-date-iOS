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
    var lookingFor: LookingForType?
    
    func updateViews() {
        guard let lookingFor = lookingFor else { return }
    }
    
    //MARK: - Outlets
    @IBOutlet weak var lookingForLabel: UILabel!
    @IBOutlet weak var uncheckButton: UIButton!
    
    @IBAction func buttonTapped(_ sender: Any) {
        guard let lookingFor = lookingFor else { return }
        let currentImage = uncheckButton.currentImage!
        let buttonEmptyImage = UIImage(named: "emptyCheck")!
        let buttonCheckImage = UIImage(named: "check")!
        
        if currentImage.pngData() != buttonEmptyImage.pngData() {
            
            DispatchQueue.main.async {
                self.uncheckButton.setImage(buttonEmptyImage, for: .normal)
            }
            let indexOfLookFor = lookingForFromTableView.firstIndex(of: lookingFor.rawValue)
            lookingForFromTableView.remove(at: indexOfLookFor!)
            //print("Current conditions 2: \(conditionsFromTableView)")
        } else {
            DispatchQueue.main.async {
                self.uncheckButton.setImage(buttonCheckImage, for: .normal)
            }
            lookingForFromTableView.append(lookingFor.rawValue)
            //print("Current looking for 1: \(conditionsFromTableView)")
        }
    }
}

var lookingForFromTableView: [String] = []
