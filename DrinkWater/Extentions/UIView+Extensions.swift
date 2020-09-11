//
//  UIView+Extensions.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/4/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

extension UIView {
    
    public  func makeRounded() {
        layer.cornerRadius = bounds.height / 2
        layer.masksToBounds = true
    }
    
    public  func dropShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
        
        layer.shouldRasterize = true
        layer.rasterizationScale = UIScreen.main.scale
    }
}
