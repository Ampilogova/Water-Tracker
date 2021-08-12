//
//  Volume.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 8/12/21.
//  Copyright © 2021 Tatiana Ampilogova. All rights reserved.
//

import UIKit

enum Volume {
    case xs
    case s
    case m

    var value: Double {
        switch (self, AppSettings.unit) {
        case (.xs, .liter): return 220
        case (.xs, .ounces): return 8
        case (.s, .liter): return 330
        case (.s, .ounces): return 12
        case (.m, .liter): return 500
        case (.m, .ounces): return 16
        }
    }
    
    var title: String {
        switch AppSettings.unit {
        case (.liter): return VolumeFormatter.string(from: value) + loc("ml")
        case (.ounces): return VolumeFormatter.string(from: value) + loc("fl.oz")
        }
    }
    
    var all: [Volume] {
        return [.xs, .s, .m]
    }
}
