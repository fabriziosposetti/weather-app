//
//  CityForecast.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

struct Forecast: Codable {
    let timezone: String
    let daily: [Daily]
}


struct Daily: Codable {
    let dt: Int
    let temp: Temp
    
    
    func getDate() -> String {
        return NSDate(timeIntervalSince1970: TimeInterval(dt)).toDayMonthAndYearString()
    }
    
}

// MARK: - Temp
struct Temp: Codable {
    let day, min, max, night: Double
    let eve, morn: Double
    
    func getStringMinTemp() -> String {
        return "\(Int(round(min))) °"
    }
    func getStringMaxTemp() -> String {
        return "\(Int(round(max))) °"
    }
}
