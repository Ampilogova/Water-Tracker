//
//  Unit:Volume.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/19/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit


// стоит сделать паку models и перенести туда
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

// Unit.customAmount = "user value" // можно удалить

enum Volume {
    case xs     //220 //7.4
    case s      //330 //11.2
    case m      //500 //17

    var value: Double {
        switch (self, AppSettingsVolume.unit) {
        case (.xs, .liter): return 220
        case (.xs, .ounces): return 7.4
        case (.s, .liter): return 330
        case (.s, .ounces): return 11.2
        case (.m, .liter): return 500
        case (.m, .ounces): return 17
        }
    }
    
    var title: String {
        switch AppSettingsVolume.unit {
        case (.liter): return VolumeFormatter.string(from: value) + loc("ml")
        case (.ounces): return String(self.value) + loc("fl.oz")
        }
    }
    
    var all: [Volume] {
        return [.xs, .s, .m]
    }
}
