//
//  AppDelegate.swift
//  Orang
//
//  Created by yeoni on 2023/09/27.
//

import UIKit
import FirebaseCore
import FirebaseMessaging

import IQKeyboardManagerSwift

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.overrideKeyboardAppearance = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        UINavigationBar.appearance().tintColor = Design.Color.tintColor
        UINavigationBar.appearance().largeTitleTextAttributes = [
            NSAttributedString.Key.font: Design.Font.scdreamExBold.getFonts(size: 30) 
        ]
        UITabBar.appearance().tintColor = Design.Color.tintColor
        UIButton.appearance().setTitleColor(Design.Color.content, for: .normal)
        UIButton.appearance().tintColor = Design.Color.tintColor
        UICollectionView.appearance().backgroundColor = Design.Color.background
        UITableView.appearance().backgroundColor = Design.Color.background
        
        FirebaseApp.configure()
        
        
        UNUserNotificationCenter.current().delegate = self
        
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
        )
        
        application.registerForRemoteNotifications()
        
        
        Messaging.messaging().delegate = self
        
        Messaging.messaging().token { token, error in
            if let error = error {
                print("Error fetching FCM registration token: \(error)")
            } else if let token = token {
                print("FC registration token: \(token)")
            }
        }
        
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}


extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let token = deviceToken.map { String(format: "%02.2hhx", $0) }.joined()
        print("apple token: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
//    func registerForRemoteNotification(application: UIApplication) {
//        UNUserNotificationCenter.current().delegate = self
//        
//        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
//        UNUserNotificationCenter.current().requestAuthorization(
//            options: authOptions,
//            completionHandler: { _, _ in }
//        )
//
//        application.registerForRemoteNotifications()
//    }
}

extension AppDelegate: MessagingDelegate {
    
//    func registerAndLoadToken() {
//        
//        Messaging.messaging().token { token, error in
//            if let error = error {
//                print("Error fetching FCM registration token: \(error)")
//            } else if let token = token {
//                print("FC registration token: \(token)")
//            }
//        }
//    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
        print("\(String(describing: fcmToken))")
        
        // 토큰 갱신 모니터링
        let dataDict: [String: String] = ["token": fcmToken ?? ""]
        NotificationCenter.default.post(
            name: Notification.Name("FCMToken"),
            object: nil,
            userInfo: dataDict
        )
    }
    
}
