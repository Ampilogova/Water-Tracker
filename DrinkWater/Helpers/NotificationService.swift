//
//  NotificationService.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 8/31/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit
import NotificationCenter

class NotificationService {
    
    func notificationsScheduler(hours: [Int]) {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        let content = UNMutableNotificationContent()
        content.title = "Water Tracker" // localize
        content.body = "Don't forget to drink a glass of water" // localize
        content.sound = UNNotificationSound.default
        
        for time in hours {
            let dateComponents = DateComponents(hour: time)
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let request = UNNotificationRequest(identifier: "LocalNotification " + String(time), content: content, trigger: trigger) //LocalNotification -> id
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
    }
}


