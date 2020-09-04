//
//  AppDelegate.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/3/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

// Нужно пройтись по всем методам в проекте и проставить private где надо

// Предлагаемая структура проекта:
// UserStories
//    Main
//    NotificationsSettings
//    Hystory
//    Settings
//  Helpers
//  Extentions
//  Services

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    // Неиспользуемый код
//    UNUserNotificationCenterDelegate
    
//    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
//        completionHandler([.alert, .sound])
//    }
//
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//        if response.notification.request.identifier == "LocalNotification" {
//            print("Handling notification with identifier 'LocalNotification'")
//        }
//        completionHandler()
//    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Неиспользуемый код
//        UNUserNotificationCenter.current().delegate = self
        
        // лучше вынести в отдельный метод
        let notificationenter = UNUserNotificationCenter.current()
        let options: UNAuthorizationOptions = [.alert, .sound]
        notificationenter.requestAuthorization(options: options) { (didAllow, error) in
            if !didAllow {
                print("User has declined notifications")
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

    // метод можно удалить
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

