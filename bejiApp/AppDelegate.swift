//
//  AppDelegate.swift
//  bejiApp
//
//  Created by Sousuke Ikemoto on 2020/11/04.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {


//    UINavigationBar.appearance().shadowImage = UIImage()
//    UINavigationBar.appearance().barTintColor = UIColor(hex: "92AD78")
    var window: UIWindow?
    func setup() {
        //UserDefaults.standard.set(false, forKey: "visit") //リセット用
//        let visit = UserDefaults.standard.bool(forKey: "visit")
//        if visit {
//            //二回目以降
//            print("二回目以降")
//        } else {
//            //初回アクセス
//            print("初回起動")
//            UserDefaults.standard.set(true, forKey: "visit")
//        }
        let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")

                if(launchedBefore == true) {
                   
                    //動作確認のために1回実行ごとに値をfalseに設定し直す
                    UserDefaults.standard.set(false, forKey: "launchedBefore")
                    print("初回")
         
                } else {
                    //起動を判定するlaunchedBeforeという論理型のKeyをUserDefaultsに用意
                    UserDefaults.standard.set(true, forKey: "launchedBefore")
                }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        setup()
        FirebaseApp.configure()
            UINavigationBar.appearance().shadowImage = UIImage()
            UINavigationBar.appearance().barTintColor = UIColor(hex: "92AD78")
       let center = UNUserNotificationCenter.current()
              center.removeAllPendingNotificationRequests()
              center.requestAuthorization(options:[.badge,.alert,.sound]){ (granted,error) in
                  if granted {
                     print("通知許可")
                  }
             }
              center.delegate = self
              
              window = UIWindow(frame: UIScreen.main.bounds)
              window?.makeKeyAndVisible()
      
        return true
    }
    @available(iOS 10, *)
       func userNotificationCenter(_ center: UNUserNotificationCenter,
                                   willPresent notification: UNNotification,
                                   withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           let userInfo = notification.request.content.userInfo
           completionHandler(UNNotificationPresentationOptions.alert)
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

