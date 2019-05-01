//
//  SwipingController.swift
//  FirstDate
//
//  Created by Lambda_School_Loaner_34 on 4/30/19.
//  Copyright © 2019 Frulwinn. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //collectionView?.backgroundColor = .white
        collectionView?.register(PageCell.self, forCellWithReuseIdentifier: "cellId") //refering to pagecell
        collectionView?.isPagingEnabled = true //snaps
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) //as! PageCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ? .red: .green // if the index path is divisible by 2 otherwise it is set to green, alternating colors
        
        //let page = pages[indexPath.item]
//        cell.heartImageView.image = UIImage(named: page.imageName)
//        cell.descriptionTextView.text = page.headerText
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
        //return CGSize(width: 100, height: 100) //just makes red squares certain size
    }
}
