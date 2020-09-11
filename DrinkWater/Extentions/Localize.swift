//
//  Localize.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 2/27/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import Foundation

public func loc(_ string: String) -> String {
    return NSLocalizedString(string, tableName: nil, bundle: Bundle.main, value: "", comment: "")
}
