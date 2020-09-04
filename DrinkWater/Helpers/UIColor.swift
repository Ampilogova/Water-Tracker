//
//  UIColor.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/24/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit
// стоит сделать паку extentions и перенести туда
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}
