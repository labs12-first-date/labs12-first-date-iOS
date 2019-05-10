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
        DispatchQueue.main.async {
            self.checkMarkButton.imageView?.image = UIImage(named: "check")
        }
        
        // add to an array of conditions for the user
        
    }
    

}
