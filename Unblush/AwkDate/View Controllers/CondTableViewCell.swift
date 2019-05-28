//
//  CondTableViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/10/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class CondTableViewCell: UITableViewCell {

    var condition: String? {
        didSet {
            updateViews()
        }
    }
    
    var index: Int? {
        didSet{
            
        }
    }
    func updateViews() {
        guard let condition = condition else { return }
        
        let buttonCheckImage = UIImage(named: "check")!
        let buttonEmptyImage = UIImage(named: "emptyCheck")!
        
        if conditionsFromTableView.contains(condition) {
            checkMarkButton.setImage(buttonCheckImage, for: .normal)
        } else {
            checkMarkButton.setImage(buttonEmptyImage, for: .normal)
        }
        
        conditionNameLabel.textColor = .grape
        conditionNameLabel.font = AppearanceHelper.lightFont(with: .body, pointSize: 16)
        //checkMarkButton.tintColor = .grape
        
    }
    
    @IBOutlet weak var conditionNameLabel: UILabel!
    
    @IBOutlet weak var checkMarkButton: UIButton!
    
    @IBAction func checkMarkTapped(_ sender: UIButton) {
        guard let condition = condition else { return }
        let currentImage = checkMarkButton.currentImage!
        
        let buttonEmptyImage = UIImage(named: "emptyCheck")!
        let buttonCheckImage = UIImage(named: "check")!
        
        if currentImage.pngData() != buttonEmptyImage.pngData() {
            
            DispatchQueue.main.async {
                self.checkMarkButton.setImage(buttonEmptyImage, for: .normal)
            }
            let indexOfSTD = conditionsFromTableView.firstIndex(of: condition)
            conditionsFromTableView.remove(at: indexOfSTD!)
            print("Current conditions 2: \(conditionsFromTableView)")
        } else {
            DispatchQueue.main.async {
                self.checkMarkButton.setImage(buttonCheckImage, for: .normal)
            }
            conditionsFromTableView.append(condition)
            print("Current conditions 1: \(conditionsFromTableView)")
        }
    }
    
    
}
var conditionsFromTableView: [String] = []
