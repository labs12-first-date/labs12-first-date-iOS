//
//  ConvertPhotoOperation.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/29/19.
//  Copyright © 2019 JS. All rights reserved.
//

import Foundation
import UIKit

/*class ConvertPhotoOperation: ConcurrentOperation {
    
    init(fileName: String) {
        self.fileName = fileName
        super.init()
    }
    
    override func start() {
        
        state = .isExecuting
        
        let url = NSURL(string: fileName)
        let newURL = NSURL(string: fileName)
        
        let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        do {
            let imageData = try Data(contentsOf: newURL! as URL)
            print("Image data: \(imageData)")
            self.image = UIImage(data: imageData)!
            defer {
                self.state = .isFinished
            }
           // return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
            return
        }
       
        
    }
    
   /* override func cancel() {
        
    }*/
 
    
    // image, fetchOperation
   // let fetchOperation: FetchPhotoOperation
    var image: UIImage?
    let fileName: String
}*/

class ConvertPhotoOperation: Operation {

    init(fileName: String) {
        self.fileName = fileName
        super.init()
    }
    
    override func main() {
        // do our work
        let url = NSURL(string: fileName)
        let newURL = NSURL(string: fileName)
        
        let imagePath: String = url!.path! //"\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/\(url).png"
        let imageUrl: URL = URL(fileURLWithPath: imagePath)
        do {
            let imageData = try Data(contentsOf: newURL! as URL)
            print("Image data: \(imageData)")
            self.image = UIImage(data: imageData)!
            // return UIImage(data: imageData)
        } catch {
            print("Error loading image : \(error)")
            return
        }
        
    }
    
    var image: UIImage?
    let fileName: String

}



/*
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
 }*/
