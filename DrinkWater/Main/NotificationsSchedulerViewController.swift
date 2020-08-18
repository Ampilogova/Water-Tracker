//
//  NotificationsSchedulerViewController.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 8/17/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit
import UserNotifications

class NotificationsSchedulerViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let content = UNMutableNotificationContent()
        content.title = "Title"
        content.body = "This is example how to create"
        content.sound = UNNotificationSound.default
        content.badge = 1
        
        let date = Date().addingTimeInterval(2)
        let calendar = Calendar(identifier: .gregorian)
        let dateComponents = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let request = UNNotificationRequest(identifier: "LocalNotification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
}
