//
//  ChooseSignupOrLoginViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_34 on 5/8/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import FirebaseAuth

class SignupOrLoginViewController: UIViewController, UIScrollViewDelegate {
    
    //MARk: - Properties
    var images: [String] = ["0", "1", "2", "3", "4"]
    var frame = CGRect(x: 0, y: 0, width: 0, height: 0)
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    var serverCurrentUserInitial: User?
    var userController: User2Controller?
    var currentUserUID: String?
    
    //MARK: - Outlets
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var signupButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "login", sender: self)
    }
    
    @IBAction func signupButton(_ sender: Any) {
        performSegue(withIdentifier: "signup", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        setScrollView()
        setNeedsStatusBarAppearanceUpdate()
        
<<<<<<< HEAD
        serverCurrentUserInitial = Auth.auth().currentUser
        
        if serverCurrentUserInitial != nil {
=======
        /*if serverCurrentUserInitial != nil {
>>>>>>> master
            print("Initial Current User: \(serverCurrentUserInitial?.email)")
            
           /* let pushManager = PushNotificationManager(userID: serverCurrentUserInitial!.uid)
            pushManager.registerForPushNotifications()*/
            
            currentUserUID = serverCurrentUserInitial!.uid
            userController = User2Controller()
            self.userController?.currentUserUID = serverCurrentUserInitial!.uid
            performSegue(withIdentifier: "profile", sender: self)
        }
        */
        
        do {
            try Auth.auth().signOut()
            print("signed out")
            print("User in view did load: \(serverCurrentUserInitial?.uid)")
            
        } catch {
            print("error")
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "profile" {
            guard let destination = segue.destination as? ProfileViewController else { return }
            
            destination.currentUserUID = self.currentUserUID
            destination.user2Controller = self.userController
        }
    }
    
    func setScrollView() {
        pageControl.numberOfPages = images.count
        for index in 0..<images.count {
            //align scroll view
            frame.origin.x = scrollView.frame.size.width
                //equal to the scrollview times the amount of images
                * CGFloat(index)
            frame.size = scrollView.frame.size
            
            //initialize scrollview to image
            let imgView = UIImageView(frame: frame)
            imgView.image = UIImage(named: images[index])
            self.scrollView.addSubview(imgView)
        }
        
        //set content size of scrollview
        scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(images.count)), height: scrollView.frame.size.height)
        //set viewcontroller delegate
        scrollView.delegate = self
    }
    
    func setTheme() {
        view.backgroundColor = .violet
        AppearanceHelper.style(button: loginButton)
        AppearanceHelper.style(button: signupButton)

    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //will tell us what page we are on
        var pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        
        pageControl.currentPage = Int(pageNumber)
    }
}

