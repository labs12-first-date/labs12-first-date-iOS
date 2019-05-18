 //
//  BogusMatchesCollectionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import FirebaseAuth

private let reuseIdentifier = "MatchCell"

class BogusMatchesCollectionViewController: UICollectionViewController {
    
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
    
    var filteredProfiles: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
       /* self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier) */
        
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
                
                if self.lookingFor!.contains(.openToAllPossibilities) {
                    self.filteredProfiles = locationProfiles
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        print("Number of matches: \(self.filteredProfiles.count)")
                    }
                    return
                }
                
                var ageProfiles = [[String:Any]]()
                var genderProfiles = [[String:Any]]()
                
                if self.lookingFor!.contains(.fiveYearAgeGap) {
                    self.ageGap = 5
                    ageProfiles = self.filterByAge(profiles: locationProfiles)
                    
                } else if self.lookingFor!.contains(.threeYearAgeGap) {
                    self.ageGap = 3
                    ageProfiles = self.filterByAge(profiles: locationProfiles)
                } else if self.lookingFor!.contains(.tenYearAgeGap) {
                    self.ageGap = 10
                    ageProfiles = self.filterByAge(profiles: locationProfiles)
                }
            
                if self.lookingFor!.contains(.sameCondition) {
                    let conditionProfiles = self.filterByCondition(profiles: ageProfiles)
                    
                    if self.lookingFor!.contains(.sameGender) {
                        genderProfiles = self.filterByGender(profiles: conditionProfiles)
                        self.filteredProfiles = genderProfiles
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            print("Number of matches: \(self.filteredProfiles.count)")
                        }
                        return
                    }
                    self.filteredProfiles = conditionProfiles
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        print("Number of matches: \(self.filteredProfiles.count)")
                    }
                    return
                } else if self.lookingFor!.contains(.openToAllConditions) {
                    
                    if self.lookingFor!.contains(.sameGender) {
                        genderProfiles = self.filterByGender(profiles: ageProfiles)
                        self.filteredProfiles = genderProfiles
                        DispatchQueue.main.async {
                            self.collectionView.reloadData()
                            print("Number of matches: \(self.filteredProfiles.count)")
                        }
                        return
                    }
                    self.filteredProfiles = ageProfiles
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                        print("Number of matches: \(self.filteredProfiles.count)")
                    }
                    return
                }
            
            }
        }

        
        
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
    
    private func load(fileName: String) -> UIImage? {
        print("file name: \(fileName)")
        let url = NSURL(string: fileName)
        let newURL = NSURL(string: fileName)
        
        let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        do {
            let imageData = try Data(contentsOf: newURL! as URL)
            print("Image data: \(imageData)")
            return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
        }
        return nil
    }

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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! BogusMatchCollectionViewCell
    
        let profile = self.filteredProfiles[indexPath.item]
        
        cell.layer.borderWidth = 2
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.cornerRadius = 8
        
        cell.matchImageView.image = self.load(fileName: profile["profile_picture"] as! String)
        cell.matchAgeLabel.text = profile["age"] as! String
        cell.matchBioLabel.text = profile["bio"] as! String
        cell.matchLocationLabel.text = profile["zip_code"] as! String
        cell.matchNameLabel.text = profile["first_name"] as! String
        
        cell.profile = profile
        cell.userController = self.userController
        
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}
