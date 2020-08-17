//
//  NSObject+Extensions.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/10/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import Foundation

extension NSObject {

    public var className: String {
        return String(describing: type(of: self)).components(separatedBy: ".").last ?? ""
    }

    public static var className: String {
        return String(describing: self).components(separatedBy: ".").last ?? ""
    }
}

