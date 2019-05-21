//
//  ChooseSignupOrLoginViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupOrLoginViewController: UIViewController {
    
    //MARk: - Properties
    var onboarding = Onboarding.fetchInterests()
    let cellScaling: CGFloat = 0.6
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    //MARK: - Outlets
    @IBOutlet weak var logoView: UIImageView!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "signup", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setNeedsStatusBarAppearanceUpdate()

        let screenSize = UIScreen.main.bounds.size
        let cellWidth = floor(screenSize.width * cellScaling)
        let cellHeight = floor(screenSize.height * cellScaling)

        let insetX = (view.bounds.width - cellWidth) / 2.0
        let insetY = (view.bounds.height - cellHeight) / 2.0

        let layout = collectionView!.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize = CGSize(width: cellWidth, height: cellHeight)
        collectionView?.contentInset = UIEdgeInsets(top: insetY, left: insetX, bottom: insetY, right: insetX)

        //collectionView?.dataSource = self
       // collectionView?.delegate = self
        
        do {
            try Auth.auth().signOut()
            print("signed out")
            //print("User in view did load: \(userController.serverCurrentUser?.uid)")
            
        } catch {
            print("error")
        }

    }
    
    func setTheme() {
        view.backgroundColor = .violet
        AppearanceHelper.style(button: loginButton)
        AppearanceHelper.style(button: signupButton)

    }
}

extension SignupOrLoginViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return onboarding.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCell", for: indexPath) as! OnboardingCollectionViewCell
        
        cell.onboarding = onboarding[indexPath.item]
        
        return cell
    }
}

extension SignupOrLoginViewController: UIScrollViewDelegate, UICollectionViewDelegate {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let layout = self.collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        let cellWidthIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWidthIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWidthIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

