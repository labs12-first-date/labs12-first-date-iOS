//
//  OnboardingViewController.swift
//  FirstDate
//
//  Created by Lambda_School_Loaner_34 on 5/2/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class OnboardingViewController: UIViewController, UICollectionViewDelegate { //}, UICollectionViewDataSource, UIScrollViewDelegate {
    
    //MARK: - Properties
    var nameLabel = UILabel()
    var textField = UITextField()
    
    //MARK: - Outlets
    @IBOutlet weak var scrollView: UIScrollView! {
        didSet {
            scrollView.addSubview(nameLabel)
            scrollView.addSubview(textField)
            
        }
    }
    @IBOutlet weak var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
