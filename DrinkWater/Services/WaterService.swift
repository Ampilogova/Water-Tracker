//
//  WaterService.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/30/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit

class WaterService {
    
    let userDefaults = UserDefaults.standard

    public func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // 1. Show the amount of water drunk for today and for a specific date
    public func waterAmount(at date: String) -> Double {
        
        let waterData = userDefaults.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let values = dict[date] ?? [:]
        var result = 0.0
        for element in values {
            result = result + element.value
        }
        
        return result
    }
    
    public func currentWaterAmount() -> Double {
        return waterAmount(at: currentDate())
    }
    
    // 2. Display the current time.
    
    public func currentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    // 3. The user enters a new value. Write the value on the current day at the current time
    
    public func addWater(value: Double) {
        let waterData = userDefaults.value(forKey: "Water")
        var dict = waterData as? [String: [String: Double]] ?? [:]
        let dataKey = currentDate()
        if dict[dataKey] == nil {
            dict[dataKey] = [String: Double]()
        }
        dict[dataKey]?[currentTime()] = value
        userDefaults.set(dict, forKey: "Water")
    }
    
    // 4. Display all days and the amount of water drunk on these days, Dates must be sorted in descending order
    public  func history() -> [(date: String, value: Double)] {
        let waterData = userDefaults.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let days = Array(dict.keys)
        var results = [Double]()
        for day in days {
            let result = waterAmount(at: day)
            results.append(result)
        }
        
        var historyArray = [(date: String, value: Double)]()
        for (day, result) in zip(days, results) {
            historyArray.append((day, result))
        }
        
        return historyArray.sorted(by: { $01.date < $0.date })
    }
    
    // 5. Show the history of the water you drink for a specific day
    
    public func water(at date: String) -> [(time: String, value: Double)] {
        let waterData = userDefaults.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let dayDict = dict[date] ?? [:]
        
        var result = [(time: String, value: Double)]()
        for element in dayDict {
            result.append((element.key, element.value))
        }
        
        return result.sorted(by: { $0.time < $1.time })
    }
    
    public  func remove()  {
        userDefaults.removeObject(forKey: "Water")
    }
    
    public func undo() {
        let waterData = userDefaults.value(forKey: "Water")
        var dict = waterData as? [String: [String: Double]] ?? [:]
        let dataKey = currentDate()
        var values = dict[dataKey] ?? [:]
        let keys = values.enumerated().map({ $0.element.key }).sorted(by: { $0 < $1 })
        values.removeValue(forKey: keys.last ?? "")
        dict[dataKey] = values
        userDefaults.set(dict, forKey: "Water")
    }

public  func isEmpty() -> Bool {
    if userDefaults.value(forKey: "Water") != nil {
        return false
        } else {
            return true
        }
    }
}
