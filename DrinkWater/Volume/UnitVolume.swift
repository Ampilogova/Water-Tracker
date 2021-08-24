//
//  Unit:Volume.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/19/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit

enum UnitVolume: String {
    case liter
    case ounces
    
    var maxAmount: Double {
        if UnitVolume.customAmount != 0.0 {
            return UnitVolume.customAmount
        }
        
        switch self {
        case (.liter): return 2000
        case (.ounces): return 64
        }
    }
    static let appGroup = "group.com.drink.water"

    static var customAmount: Double {
        get { return UserDefaults(suiteName: appGroup)?.double(forKey: #function) ?? 0.0 }
        set { UserDefaults(suiteName: appGroup)?.setValue(newValue, forKey: #function) }
    }
}
