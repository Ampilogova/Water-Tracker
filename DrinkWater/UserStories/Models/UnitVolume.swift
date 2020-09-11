//
//  UnitVolume.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 9/9/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import Foundation

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
    static var customAmount: Double {
        get { return UserDefaults.standard.double(forKey: #function) }
        set { UserDefaults.standard.set(newValue, forKey: #function) }
    }
}
