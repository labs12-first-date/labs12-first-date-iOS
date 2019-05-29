//
//  PushNotificationSender.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 5/28/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit

class PushNotificationSender {
    func sendPushNotification(to token: String, title: String, body: String) {
        let urlString = "https://fcm.googleapis.com/fcm/send"
        let url = NSURL(string: urlString)!
        let paramString: [String : Any] = ["to" : token,
                                           "notification" : ["title" : title, "body" : body, "sound": "default", "badge": "1"],
                                           "data" : ["user" : "test_id"], "priority": "high"
        ]
        let request = NSMutableURLRequest(url: url as URL)
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject:paramString, options: [.prettyPrinted])
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("key=AAAAK-1ANiY:APA91bGC4FPlIy6q4pnlExRH35JfidvOHiqPgMIkMhczdkT_samFnFY6K4uoM77JaXhcKIY0L0xgjt7g8xeHhE_TUZNevVmq97Hcxg-mwVfjZxbH-J9r7WVuCqI6DBSnIXncLrSMc3Xr", forHTTPHeaderField: "Authorization")
        let task =  URLSession.shared.dataTask(with: request as URLRequest)  { (data, response, error) in
            do {
                if let jsonData = data {
                    if let jsonDataDict  = try JSONSerialization.jsonObject(with: jsonData, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: AnyObject] {
                        NSLog("Received data:\n\(jsonDataDict))")
                    }
                }
            } catch let err as NSError {
                print(err.debugDescription)
            }
        }
        task.resume()
    }
}
