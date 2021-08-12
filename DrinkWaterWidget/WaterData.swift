//
//  WaterData.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 8/4/21.
//  Copyright © 2021 Tatiana Ampilogova. All rights reserved.
//

import Foundation

struct WaterData: Identifiable, Codable, Hashable {
    var currentAmount: Double
    var date: String
    var volume: String
    
    var id: String { date }
    
    private static let appGroup = "group.com.drink.water"
    
    static func getWater() -> WaterData {
        return WaterData(currentAmount: getLastAmountWater(), date: lastDrinkTime(), volume: volumeFormatter())
    }
    
    static func getLastAmountWater() -> Double {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let values = dict[dateFormatter.string(from: date)] ?? [:]
        var result = 0.0
        for element in values {
            result = result + element.value
        }
        
        return result
    }
    
    static public func lastDrinkTime() -> String {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let dayDict = dict[dateFormatter.string(from: date)] ?? [:]
        
        var result = [String]()
        for time in dayDict {
            result.append(timeFormatter(str: time.key))
        }
        result.sort()
        
        return result.last ?? ""
    }
    
    static func stringFormatter(from value: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 0
        
        if AppSettings.unit == .liter {
            return numberFormatter.string(from: NSNumber(value: value)) ?? ""
        }
        return numberFormatter.string(from: NSNumber(value: value)) ?? ""
    }
    
    static func volumeFormatter() -> String {
        if AppSettings.unit == .liter {
            return loc("ml")
        }
        return loc("fl.oz")
    }
    
    static func timeFormatter(str: String) -> String {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = TimeZone.current
        let time = dateFormatter.date(from: str) ?? Date()
        
        let dateFormatterTime = DateFormatter()
        dateFormatterTime.dateFormat = "HH:mm"
        return dateFormatterTime.string(from: time)
    }
    
}




