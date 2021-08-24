//
//  UIColor.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/24/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

public extension UIColor {
    
    
    
    static let aqua = UIColor(red: 14/255.0, green: 231/255.0, blue: 252/255.0, alpha: 1.0)
    static let tealAqua = UIColor(red: 191/255.0, green: 249/255.0, blue: 253/255.0, alpha: 1.0)
    static let customGray = UIColor(red: 172/255.0, green: 170/255.0, blue: 170/255.0, alpha: 1.0)
    
    
    static var tint: UIColor = {
        if #available(iOS 13, *) {
            return UIColor { (UITraitCollection: UITraitCollection) -> UIColor in
                if UITraitCollection.userInterfaceStyle == .dark {
                    return .black
                } else {
                    return .systemBackground
                }
            }
        } else {
            return .systemBackground
        }
    }()
}
