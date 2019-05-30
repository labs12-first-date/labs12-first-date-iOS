//
//  AppDelegate.swift
//  AwkDate
//
//  Created by Lambda_School_Loaner_95 on 4/30/19.
//  Copyright © 2019 JS. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
   
    let domain = Bundle.main.bundleIdentifier!
    let defaults = UserDefaults.standard
    
   // var serverCurrentUserAppDelegate = Auth.auth().currentUser

    //let userController = User2Controller()
    var token: String?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //AppController.shared.show(in: UIWindow(frame: UIScreen.main.bounds))
        //let userController = User2Controller()
        
        defaults.removePersistentDomain(forName: domain)
        defaults.synchronize()
        print(Array(defaults.dictionaryRepresentation().keys).count) 
        
       /* if userController.serverCurrentUser != nil {
            print("User in App Delegate!")
            let pushManager = PushNotificationManager(userID: userController.serverCurrentUser!.uid)
            pushManager.registerForPushNotifications()
        } */
        
       /* let pushManager = PushNotificationManager(userID: "gRU36yUbDBbxY3pDPrhNfVNddF93")
        pushManager.registerForPushNotifications()*/
        
        FirebaseApp.configure()
        
       /* let sender = PushNotificationSender()
        sender.sendPushNotification(to: token ?? "token", title:
            "Notification title", body: "Notification body")*/
     
        AppearanceHelper.Appearance()
        return true
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        print("Receive Remote Notification!")
        
    }
    
    // f6c4ec0a0c3f783573271aeaee051707b8f4f826050f67c0394f23349bb461e4
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        //token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
       // 1c94141123e23caa7ba685bec04cac3aca7eb66fecff0c0de6d149b6b5c84d82
        
        print("Receive Remote Notification!")
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}
