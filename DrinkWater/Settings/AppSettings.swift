//
//  Settings.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/17/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class AppSettings {
    
    static let appGroup = "group.com.drink.water"
    
    static var unit: UnitVolume {
         get {
             let value = UserDefaults(suiteName: appGroup)?.string(forKey:  #function)  ?? ""
             return UnitVolume(rawValue: value) ?? .liter
         }
         set {
             UserDefaults(suiteName: appGroup)?.setValue(newValue.rawValue, forKey: #function)
         }
    }
}
