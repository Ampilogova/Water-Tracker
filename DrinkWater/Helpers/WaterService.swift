//
//  WaterService.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/30/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit
import WidgetKit

class WaterService {
    
<<<<<<< Updated upstream:DrinkWater/Helpers/WaterService.swift
    let userDefaults = UserDefaults.standard
    
    func printWater() {
        let waterData = userDefaults.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        print(dict)
    }
    
    func currentDate() -> String {
=======
    let appGroup = "group.com.drink.water"
    
    public func currentDate() -> String {
>>>>>>> Stashed changes:DrinkWater/Services/WaterService.swift
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
<<<<<<< Updated upstream:DrinkWater/Helpers/WaterService.swift
    // 1. Показывать количество выпитой воды за сегодня и за определенную дату
    func waterAmount(at date: String) -> Double {
        
        let waterData = userDefaults.value(forKey: "Water")
=======
    // 1. Show the amount of water drunk for today and for a specific date
    public func waterAmount(at date: String) -> Double {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
>>>>>>> Stashed changes:DrinkWater/Services/WaterService.swift
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let values = dict[date] ?? [:]
        var result = 0.0
        for element in values {
            result = result + element.value
        }
        
        return result
    }
    
    func currentWaterAmount() -> Double {
        return waterAmount(at: currentDate())
    }
    
    // 2. вывести текущее время. Должно получиться что то типа 15:23:44 hh:mm:ss
    
    func currentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    // 3. Пользователь вносит новое значение нужно его записать. Записать в текущий день по текущему времени значение
    
<<<<<<< Updated upstream:DrinkWater/Helpers/WaterService.swift
    func addWater(value: Double) {
        let waterData = userDefaults.value(forKey: "Water")
=======
    public func addWater(value: Double) {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
>>>>>>> Stashed changes:DrinkWater/Services/WaterService.swift
        var dict = waterData as? [String: [String: Double]] ?? [:]
        let dataKey = currentDate()
        if dict[dataKey] == nil {
            dict[dataKey] = [String: Double]()
        }
        dict[dataKey]?[currentTime()] = value
        UserDefaults(suiteName: appGroup)?.setValue(dict, forKey: "Water")
        reloadWidget()
    }
    
<<<<<<< Updated upstream:DrinkWater/Helpers/WaterService.swift
    // 4. Вывести все дни и количество выпитой воды в эти дни, Даты должны быть отсортированы по убыванию
    func history() -> [(date: String, value: Double)] {
        let waterData = userDefaults.value(forKey: "Water")
=======
    // 4. Display all days and the amount of water drunk on these days, Dates must be sorted in descending order
    public  func history() -> [(date: String, value: Double)] {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
>>>>>>> Stashed changes:DrinkWater/Services/WaterService.swift
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
        
        return historyArray.sorted(by: { $0.date < $1.date })
    }
    
    // 5. Показать историю выпитой воды за определенный день 
    
<<<<<<< Updated upstream:DrinkWater/Helpers/WaterService.swift
    func water(at date: String) -> [(time: String, value: Double)] {
        let waterData = userDefaults.value(forKey: "Water")
=======
    public func water(at date: String) -> [(time: String, value: Double)] {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
>>>>>>> Stashed changes:DrinkWater/Services/WaterService.swift
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let dayDict = dict[date] ?? [:]
        
        var result = [(time: String, value: Double)]()
        for element in dayDict {
            result.append((element.key, element.value))
        }
        
        return result.sorted(by: { $0.time < $1.time })
    }
    
<<<<<<< Updated upstream:DrinkWater/Helpers/WaterService.swift
    func remove()  {
        userDefaults.removeObject(forKey: "Water")
    }
    
    func isEmpty() -> Bool {
        if userDefaults.value(forKey: "Water") != nil {
=======
    public  func remove()  {
        UserDefaults(suiteName: appGroup)?.removeObject(forKey: "Water")
    }
    
    public func undo() {
        let waterData = UserDefaults(suiteName: appGroup)?.value(forKey: "Water")
        var dict = waterData as? [String: [String: Double]] ?? [:]
        let dataKey = currentDate()
        var values = dict[dataKey] ?? [:]
        let keys = values.enumerated().map({ $0.element.key }).sorted(by: { $0 < $1 })
        values.removeValue(forKey: keys.last ?? "")
        dict[dataKey] = values
        UserDefaults(suiteName: appGroup)?.setValue(dict, forKey: "Water")
        reloadWidget()
    }
    
    public  func isEmpty() -> Bool {
        if UserDefaults(suiteName: appGroup)?.value(forKey: "Water") != nil {
>>>>>>> Stashed changes:DrinkWater/Services/WaterService.swift
            return false
        } else {
            return true
        }
    }
    @available(iOS 14, *)
    public func reloadWidget() {
        WidgetCenter.shared.getCurrentConfigurations { result in
            guard case .success(let widgets) = result else { return }
            print(widgets)
            WidgetCenter.shared.reloadTimelines(ofKind: "WidgetDrinkWater")
        }
    }
}



