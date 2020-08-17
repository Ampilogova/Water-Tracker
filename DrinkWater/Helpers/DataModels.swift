//
//  DataModels.swift
//  DrinkWater
//
//  Created by Tatiana Ampilogova on 3/9/20.
//  Copyright © 2020 Tatiana Ampilogova. All rights reserved.
//

import Foundation

struct Weather: Codable {
    var id: Int
    var main: String
}

struct Main: Codable {
    var temp: Double = 0.0
}

struct WeatherData: Codable {
    var weather: [Weather] = []
    var main: Main = Main()
    var name: String = ""
}
