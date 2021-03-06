//
//  ConditionTableViewCell.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/10/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class ConditionTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var condition: ConditionType? {
        didSet {
            
        }
    }
    
    func updateViews() {
        guard let condition = condition else { return }
        
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
            let indexOfSTD = conditionsFromTableView.firstIndex(of: condition.rawValue)
            conditionsFromTableView.remove(at: indexOfSTD!)
            print("Current conditions 2: \(conditionsFromTableView)")
        } else {
            
            DispatchQueue.main.async {
                self.checkMarkButton.setImage(buttonCheckImage, for: .normal)
            }
            conditionsFromTableView.append(condition.rawValue)
            print("Current conditions 1: \(conditionsFromTableView)")
        }
    }
    

}

//var conditionsFromTableView: [String] = []
