//
//  VolumeFormatter.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/10/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class VolumeFormatter {
    static func string(from value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
}
