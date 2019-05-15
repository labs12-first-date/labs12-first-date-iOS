//
//  BogusMatchesCollectionViewController.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/15/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

private let reuseIdentifier = "MatchesCell"

class BogusMatchesCollectionViewController: UICollectionViewController {
    
    // From Profile VC we need to pass: UserController, Zipcode, Radius, Age, gender, looking for, condition
    
    var userController: User2Controller?
    let locationController = LocationController()
    var age: Int?
    var ageGap: Int?
    var zipcode: Int?
    var gender: GenderType?
    var lookingFor: [LookingForType] = []
    var userCondition: [String] = []
    var radius: Int? = 25 //25 miles is default radius
    var zipcodesInRange: [JCSLocation] = []
    
    var filteredProfiles: [[String:Any]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
       /* self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier) */
        
        let baseURLString = "https://www.zipcodeapi.com/rest/2pU9JQu5lOgbsv1cX2C6h9l5amfnUi7fFc6aeGFlXRToiGNF7x0NJuMMeSQ47E0j/radius.json/\(zipcode)/\(radius)/mile"
        
        locationController.fetchAllLocations(baseURLString) { (zipcodes, error) in
            if let error = error {
                print("Error fetching locations in vc: \(error)")
                return
            }
            self.zipcodesInRange = self.locationController.locations // or zipcodes form completion
            
            self.userController!.fetchAllProfilesFromServer { (error) in
                if let error = error {
                    print("Error fetching ALL profiles in vc: \(error)")
                    return
                }
                let profilesFromServer = self.userController!.profilesFromServer
                let locationProfiles = self.filterByLocation(profiles: profilesFromServer)
                
                if self.lookingFor.contains(.openToAllPossibilities) {
                    self.filteredProfiles = locationProfiles
                    return
                }
                
                var ageProfiles = [[String:Any]]()
                
                if self.lookingFor.contains(.fiveYearAgeGap) {
                    self.ageGap = 5
                    ageProfiles = self.filterByAge(profiles: locationProfiles)
                    
                } else if self.lookingFor.contains(.threeYearAgeGap) {
                    self.ageGap = 3
                    ageProfiles = self.filterByAge(profiles: locationProfiles)
                } else if self.lookingFor.contains(.tenYearAgeGap) {
                    self.ageGap = 10
                    ageProfiles = self.filterByAge(profiles: locationProfiles)
                }
                
                if self.lookingFor.contains(.sameGender) {
                    // filter on gender
                }
                
                
                

                if self.lookingFor.contains(.sameCondition) {
                    let conditionProfiles = self.filterByCondition(profiles: ageProfiles)
                    self.filteredProfiles = conditionProfiles
                    return
                } else if self.lookingFor.contains(.openToAllConditions) {
                    self.filteredProfiles = ageProfiles
                    return
                }
            
            }
        }

        
        
    }

    func filterByLocation(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        
        for profile in profiles {
            for zipcode in zipcodesInRange {
                let zipInt = profile["zip_code"]!
                if (zipInt as! Int) == Int(zipcode.zipcode) {
                    profilesFiltered.append(profile)
                }
            }
        }
        return profilesFiltered
    }
    
    func filterByAge(profiles: [[String:Any]]) -> [[String:Any]] {
        
        var profilesFiltered = [[String:Any]]()
        let oldestAge = age! + ageGap!
        
        for profile in profiles {
            let ageInt = profile["age"]!
            if (ageInt as! Int) > age! && (ageInt as! Int) < oldestAge {
                profilesFiltered.append(profile)
            }
        }
        
        return profilesFiltered
    }
    
    func filterByCondition(profiles: [[String:Any]]) -> [[String:Any]] {
        var profilesFiltered = [[String:Any]]()
        var conditions = [String]()
        
        for profile in profiles {
            conditions = profile["condition"] as! [String]
            for userCond in userCondition {
                if conditions.contains(userCond) {
                    profilesFiltered.append(profile)
                }
            }
        }
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
        return 0
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
    
        // Configure the cell
    
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
