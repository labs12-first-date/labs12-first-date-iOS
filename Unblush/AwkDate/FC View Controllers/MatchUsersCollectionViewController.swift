//
//  MatchUsersCollectionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/20/19.
//  Copyright © 2019 JS. All rights reserved.
//
import UIKit
import FirebaseAuth

private let reuseIdentifier = "MatchCell"
var filteredProfiles: [[String:Any]] = []

class MatchUsersCollectionViewController: UICollectionViewController, UINavigationControllerDelegate {
    
    // From Profile VC we need to pass: UserController, Zipcode, Radius, Age, gender, looking for, condition
    
    var userController: User2Controller?
    let locationController = LocationController()
    var currentUser: User?
    var age: Int?
    var ageGap: Int?
    var zipcode: Int?
    var gender: GenderType?
    var lookingFor: [LookingForType]?
    var userCondition: [ConditionType]?
    var radius: Int? = 25 //25 miles is default radius
    var zipcodesInRange: [JCSLocation]?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            fatalError("Unable to retrieve layout")
        }
        
        let amount: CGFloat = 40
        layout.sectionInset = UIEdgeInsets(top: amount, left: amount, bottom: amount, right: amount)
        layout.itemSize = CGSize(width: 285, height: 400)
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func setTheme() {
        collectionView.backgroundColor = .violet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        
        navigationController?.delegate = self
        setNeedsStatusBarAppearanceUpdate()
        NotificationCenter.default.addObserver(self, selector: #selector(updateViews(notification:)), name: .updateCollection, object: nil)
        // Register cell classes
        /* self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier) */
        
        let image = UIImage(named: "NoMatches")
        let imageView = UIImageView(image: image!)
        filteredProfiles = [[String:Any]]()
        
        
        //Create Activity Indicator
        let myActivityIndicator = UIActivityIndicatorView(frame: CGRect(x: 100,y: 200, width: 200, height: 200))
        myActivityIndicator.style = (UIActivityIndicatorView.Style.whiteLarge)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = self.view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        DispatchQueue.main.async {
            self.view.addSubview(myActivityIndicator)
        }
        
        let baseURLString = "https://www.zipcodeapi.com/rest/ZYgKxFyo4TVdKUMOEXE0pFFvDqhguLmD4MnHfqGDUJ1rkHq2pqCSMUZ8qtgwfuij/radius.json/\(zipcode!)/\(radius!)/mile"
        print("Base URL: \(baseURLString)")
        
        locationController.fetchAllLocations(baseURLString) { (zipcodes, error) in
            if let error = error {
                print("Error fetching locations in vc: \(error)")
                return
            }
            self.zipcodesInRange = zipcodes as! [JCSLocation] // or zipcodes form completion
            print("NUmber of zipcodes in range: \(self.zipcodesInRange!.count)")
            
            self.userController!.fetchAllProfilesFromServer { (error) in
                if let error = error {
                    print("Error fetching ALL profiles in vc: \(error)")
                    return
                }
                let profilesFromServer = self.userController!.profilesFromServer
                let locationProfiles = self.filterByLocation(profiles: profilesFromServer)
                let likedProfiles = self.filterByLiked(profiles: locationProfiles)
                let dislikedProfiles = self.filterByDisliked(profiles: likedProfiles)
                
                if self.lookingFor!.contains(.openToAllPossibilities) {
                    filteredProfiles = dislikedProfiles
                    DispatchQueue.main.async {
                        if filteredProfiles.count == 0 {
                            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                            imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                            imageView.center = self.view.center
                            self.view.addSubview(imageView)
                            return
                        }
                        self.collectionView.reloadData()
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        print("Number of matches: \(filteredProfiles.count)")
                    }
                    return
                }
                
                var ageProfiles = [[String:Any]]()
                var genderProfiles = [[String:Any]]()
                
                if self.lookingFor!.contains(.fiveYearAgeGap) {
                    self.ageGap = 5
                    ageProfiles = self.filterByAge(profiles: dislikedProfiles)
                    
                } else if self.lookingFor!.contains(.threeYearAgeGap) {
                    self.ageGap = 3
                    ageProfiles = self.filterByAge(profiles: dislikedProfiles)
                } else if self.lookingFor!.contains(.tenYearAgeGap) {
                    self.ageGap = 10
                    ageProfiles = self.filterByAge(profiles: dislikedProfiles)
                } else {
                    self.ageGap = 50 // makes it so there isn't an age gap
                    ageProfiles = self.filterByAge(profiles: dislikedProfiles)
                }
                
                if self.lookingFor!.contains(.sameCondition) {
                    let conditionProfiles = self.filterByCondition(profiles: ageProfiles)
                    
                    if self.lookingFor!.contains(.sameGender) {
                        genderProfiles = self.filterByGender(profiles: conditionProfiles)
                        filteredProfiles = genderProfiles
                        DispatchQueue.main.async {
                            if filteredProfiles.count == 0 {
                                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                                imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                                imageView.center = self.view.center
                                self.view.addSubview(imageView)
                                return
                            }
                            self.collectionView.reloadData()
                            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                            print("Number of matches: \(filteredProfiles.count)")
                        }
                        return
                    }
                    filteredProfiles = conditionProfiles
                    DispatchQueue.main.async {
                        if filteredProfiles.count == 0 {
                            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                            imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                            imageView.center = self.view.center
                            self.view.addSubview(imageView)
                            return
                        }
                        self.collectionView.reloadData()
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        print("Number of matches: \(filteredProfiles.count)")
                    }
                    return
                } else if self.lookingFor!.contains(.openToAllConditions) {
                    
                    if self.lookingFor!.contains(.sameGender) {
                        genderProfiles = self.filterByGender(profiles: ageProfiles)
                        filteredProfiles = genderProfiles
                        DispatchQueue.main.async {
                            if filteredProfiles.count == 0 {
                                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                                imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                                imageView.center = self.view.center
                                self.view.addSubview(imageView)
                                return
                            }
                            self.collectionView.reloadData()
                            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                            print("Number of matches: \(filteredProfiles.count)")
                        }
                        return
                    }
                    filteredProfiles = ageProfiles
                    DispatchQueue.main.async {
                        if filteredProfiles.count == 0 {
                            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                            imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                            imageView.center = self.view.center
                            self.view.addSubview(imageView)
                            return
                        }
                        self.collectionView.reloadData()
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        print("Number of matches: \(filteredProfiles.count)")
                    }
                    return
                } else if self.lookingFor!.contains(.sameGender) {
                    genderProfiles = self.filterByGender(profiles: ageProfiles)
                    filteredProfiles = genderProfiles
                    DispatchQueue.main.async {
                        if filteredProfiles.count == 0 {
                            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                            imageView.frame = CGRect(x: 110, y: 350, width: 200, height: 200)
                            imageView.center = self.view.center
                            self.view.addSubview(imageView)
                            return
                        }
                        self.collectionView.reloadData()
                        self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                        print("Number of matches: \(filteredProfiles.count)")
                    }
                    return
                    
                }
                
            }
        }
        
        
        
    }
    
    @objc func updateViews(notification: NSNotification) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        userController?.fetchProfileFromServer(userID: userController!.currentUserUID!, completion: { (error) in
            if let error = error {
                print("Error fetching profile from server in update views: \(error)")
                return
            }
            print("Successfully fetched new profile after updating views")
        })
    }
    
    func filterByDisliked(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        let emptyArray = [[String:Any]]()
        let userDislikedArray = userController!.singleProfileFromServer["disliked"] as! [[String:Any]]
        
        if userDislikedArray.count == emptyArray.count {
            profilesFiltered = profiles
            return profilesFiltered
        }
        
        for profile in profiles {
            if userDislikedArray.contains(where: { $0["email"] as! String == profile["email"] as! String }) {
                print("Contains this: \(profile)")
            } else {
                profilesFiltered.append(profile)
            }
        }
        print("Disliked filter mutually liked: \(profilesFiltered.count)")
        return profilesFiltered
    }
    func filterByLiked(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        let emptyArray = [[String:Any]]()
        let userlikedArray = userController!.singleProfileFromServer["liked"] as! [[String:Any]]
        
        if userlikedArray.count == emptyArray.count {
            profilesFiltered = profiles
            return profilesFiltered
        }
        
        for profile in profiles {
            if userlikedArray.contains(where: { $0["email"] as! String == profile["email"] as! String }) {
                print("Contains this: \(profile)")
            } else {
                profilesFiltered.append(profile)
            }
        }
        print("Liked filter mutually liked: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
    func filterByLocation(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        
        for profile in profiles {
            for zipcode in zipcodesInRange! {
                let zipInt = profile["zip_code"]! as! String
                if Int(zipInt) == Int(zipcode.zipcode) {
                    profilesFiltered.append(profile)
                }
            }
        }
        print("Location filter matches: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
    func filterByAge(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        let oldestAge = age! + ageGap!
        let youngestAge = age! - ageGap!
        
        for profile in profiles {
            let ageInt = profile["age"]! as! String
            if Int(ageInt)! >= youngestAge && Int(ageInt)! <= oldestAge {
                profilesFiltered.append(profile)
            }
        }
        print("Age filter matches: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
    func filterByCondition(profiles: [[String:Any]]) -> [[String:Any]] {
        var profilesFiltered = [[String:Any]]()
        var conditions = [String]()
        
        for profile in profiles {
            conditions = profile["condition"] as! [String]
            for userCond in userCondition! {
                if conditions.contains(userCond.rawValue) {
                    profilesFiltered.append(profile)
                }
            }
        }
        print("Condition filter matches: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
    func filterByGender(profiles: [[String:Any]]) -> [[String:Any]]  {
        var profilesFiltered = [[String:Any]]()
        
        for profile in profiles {
            let genderString = profile["gender"] as! String
            if genderString == gender!.rawValue {
                profilesFiltered.append(profile)
            }
        }
        print("Gender filter matches: \(profilesFiltered.count)")
        return profilesFiltered
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using [segue destinationViewController].
     // Pass the selected object to the new view controller.
     }
     */
    

    
    // MARK: UICollectionViewDataSource
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return filteredProfiles.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MatchesCollectionViewCell
        
        let profile = filteredProfiles[indexPath.item]
        cell.profile = profile
        loadImage(forCell: cell, forItemAt: indexPath)
        
        //cell.layer.borderWidth = 2
        //cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 20
        cell.layer.backgroundColor = UIColor.tan.cgColor
        
       // cell.matchPhotoView.image = self.load(fileName: profile["profile_picture"] as! String)
        cell.theirAgeLabel.text = profile["age"] as! String
        cell.biographyLabel.text = profile["bio"] as! String
        cell.zipcodeLabel.text = profile["zip_code"] as! String
        cell.firstNameLabel.text = profile["first_name"] as! String
        
        
        cell.userController = self.userController
        
        
        return cell
    }
    
    private let cache = Cache<String, UIImage>()
    var convertOperations: [String: ConvertPhotoOperation] = [:]
    let photoConvertQueue = OperationQueue()
    
    override func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let profileRef = filteredProfiles[indexPath.item]
        
        let name = profileRef["profile_picture"] as! String
        
        if let operation = convertOperations[name] {
            operation.cancel()
        }
    }
    
    private func loadImage(forCell cell: MatchesCollectionViewCell, forItemAt indexPath: IndexPath) {
        let profileRef = filteredProfiles[indexPath.item]
        
        let name = profileRef["profile_picture"] as! String
        
        if let cacheImage = cache.value(for: name) {
            cell.matchPhotoView.image = cacheImage
        } else {
            
            let convertPhotoOp = ConvertPhotoOperation(fileName: name)
            convertOperations[name] = convertPhotoOp
            
            let storeImageOp = BlockOperation {
                guard let loadedPhoto = convertPhotoOp.image else { return }
                self.cache.cache(value: loadedPhoto, for: name)
            }
            
            let reuseOp = BlockOperation {
                guard let currentIndex = self.collectionView.indexPath(for: cell), let loadedPhoto = convertPhotoOp.image else { return }
                
                if currentIndex == indexPath {
                    cell.matchPhotoView.image = loadedPhoto
                    
                } else {
                    return
                }
                
            }
            
            storeImageOp.addDependency(convertPhotoOp)
            reuseOp.addDependency(convertPhotoOp)
            
            photoConvertQueue.addOperation(convertPhotoOp)
            photoConvertQueue.addOperation(storeImageOp)
            OperationQueue.main.addOperation(reuseOp)
            
        }
        
        
        
        
    }
    
    
}
