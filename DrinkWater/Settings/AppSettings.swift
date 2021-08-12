//
//  Settings.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/17/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class AppSettings {
    static var unit: UnitVolume {
        get {
            let value = UserDefaults.standard.string(forKey: #function) ?? ""
            return UnitVolume(rawValue: value) ?? .liter
        }
        set {
            UserDefaults.standard.setValue(newValue.rawValue, forKey: #function)
        }
    }
}
