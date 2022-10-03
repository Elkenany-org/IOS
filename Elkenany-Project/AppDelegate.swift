//
//  AppDelegate.swift
//  Elkenany-Project
//
//  Created by عبدالعزيز رضا  on 11/21/21.
//

import UIKit
import CoreData
import IQKeyboardManager
import UserNotifications
import GoogleSignIn


@main 
class AppDelegate: UIResponder, UIApplicationDelegate , UNUserNotificationCenterDelegate    {
    let window: UIWindow? = nil
   
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.makeKeyAndVisible()

        
//        registerForPushNotifications()
//        Messaging.messaging().delegate = self

//        @available(iOS 9.0, *)
//        func application(_ application: UIApplication, open url: URL,
//                         options: [UIApplication.OpenURLOptionsKey: Any])
//          -> Bool {
//          return GIDSignIn.sharedInstance.handle(url)
//        }
//

        //Manage-keybord
        IQKeyboardManager.shared().isEnabled = true
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        //root view controller
        let mainStoryboard = UIStoryboard(name: "Main" , bundle: nil)
       if let loginViewController = mainStoryboard.instantiateViewController(withIdentifier: "LoginVC") as? LoginVC {
            window?.rootViewController = loginViewController
        }
        
//        application.registerForRemoteNotifications()
 
    
//        let clientID = FirebaseApp.app()?.options.clientID ?? ""

        
        // Create Google Sign In configuration object.
//        let config = GIDConfiguration(clientID: clientID)

   
        
        return true
    }

    
//    func application(
//      _ app: UIApplication,
//      open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]
//    ) -> Bool {
//      var handled: Bool
//
//      handled = GIDSignIn.sharedInstance.handle(url)
//      if handled {
//        return true
//      }
//
//      // Handle other custom URL types.
//
//      // If not handled by this app, return false.
//      return false
//    }

    
    
//func registerForPushNotifications() {
//    UNUserNotificationCenter.current()
//      .requestAuthorization(
//        options: [.alert, .sound, .badge]) { [weak self] granted, _ in
//        print("Permission granted: \(granted)")
//        guard granted else { return }
//        self?.getNotificationSettings()
//      }
//  }

    
    
//    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
//      print("Firebase registration token: \(String(describing: fcmToken))")
//
//      let dataDict: [String: String] = ["token": fcmToken ?? ""]
//      NotificationCenter.default.post(
//        name: Notification.Name("FCMToken"),
//        object: nil,
//        userInfo: dataDict
//      )
//      // TODO: If necessary send token to application server.
//      // Note: This callback is fired at each app startup and whenever a new token is generated.
//    }

    
    
//    func getNotificationSettings() {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//          print("Notification settings: \(settings)")
//            guard settings.authorizationStatus == .authorized else { return }
//            DispatchQueue.main.async {
//              UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
//    }

    
//    private func application(
//      _ application: UIApplication,
//      didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
//    ) {
////
//        if #available(iOS 10.0, *) {
//          // For iOS 10 display notification (sent via APNS)
//          UNUserNotificationCenter.current().delegate = self
//
//          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//          UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: { _, _ in }
//          )
//        } else {
//          let settings: UIUserNotificationSettings =
//            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
//          application.registerUserNotificationSettings(settings)
//        }
////        Messaging.messaging().apnsToken = deviceToken
//        application.registerForRemoteNotifications()
//    }

    
    
//    func application(application: UIApplication,
//                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//    }
//
//
//
//    func application(
//      _ application: UIApplication,
//      didFailToRegisterForRemoteNotificationsWithError error: Error
//    ) {
//      print("Failed to register: \(error)")
//    }
//
//
    
    
    
}



