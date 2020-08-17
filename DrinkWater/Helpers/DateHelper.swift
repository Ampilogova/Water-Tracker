//
//  DateHelper.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 1/20/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class DateHelper {
    static func formattedDate(from date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateForTable = dateFormatter.date(from: date) ?? Date()
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateStyle = .medium
        let dateString = dateFormatter2.string(from: dateForTable)
       return dateString
    }
}
