//
//  WaterService.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 12/30/19.
//  Copyright © 2019 Tatiana Ampilogova. All rights reserved.
//

import UIKit

// стоит создать отдельную папку под сервисы

// было бы круто написать интерфейс для этого сервиса с коментариями на английском
class WaterService {
    
    let userDefaults = UserDefaults.standard
    
    // возможно этот метод больше не нужен
    func printWater() {
        let waterData = userDefaults.value(forKey: "Water") // Water лучше перенести в константу
        let dict = waterData as? [String: [String: Double]] ?? [:]
        print(dict)
    }
    
    func currentDate() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: date)
    }
    
    // 1. Показывать количество выпитой воды за сегодня и за определенную дату // коментарий можно удалить
    func waterAmount(at date: String) -> Double {
        
        let waterData = userDefaults.value(forKey: "Water")
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
    
    // 2. вывести текущее время. Должно получиться что то типа 15:23:44 hh:mm:ss // коментарий можно удалить
    
    func currentTime() -> String {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        return dateFormatter.string(from: date)
    }
    
    // 3. Пользователь вносит новое значение нужно его записать. Записать в текущий день по текущему времени значение // коментарий можно удалить
    
    func addWater(value: Double) {
        let waterData = userDefaults.value(forKey: "Water")
        var dict = waterData as? [String: [String: Double]] ?? [:]
        let dataKey = currentDate()
        if dict[dataKey] == nil {
            dict[dataKey] = [String: Double]()
        }
        dict[dataKey]?[currentTime()] = value
        userDefaults.set(dict, forKey: "Water")
    }
    
    // 4. Вывести все дни и количество выпитой воды в эти дни, Даты должны быть отсортированы по убыванию // коментарий можно удалить
    func history() -> [(date: String, value: Double)] {
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
        
        return historyArray.sorted(by: { $0.date < $1.date })
    }
    
    // 5. Показать историю выпитой воды за определенный день  // коментарий можно удалить
    
    func water(at date: String) -> [(time: String, value: Double)] {
        let waterData = userDefaults.value(forKey: "Water")
        let dict = waterData as? [String: [String: Double]] ?? [:]
        let dayDict = dict[date] ?? [:]
        
        var result = [(time: String, value: Double)]()
        for element in dayDict {
            result.append((element.key, element.value))
        }
        
        return result.sorted(by: { $0.time < $1.time })
    }
    
    func remove()  {
        userDefaults.removeObject(forKey: "Water")
    }
    
    func isEmpty() -> Bool {
        if userDefaults.value(forKey: "Water") != nil {
            return false
        } else {
            return true
        }
    }
}
