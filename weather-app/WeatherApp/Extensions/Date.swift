//
//  Date.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

extension NSDate {
    
    func toDayMonthAndYearString() -> String {
        let formatter = DateFormatter()
        formatter.timeZone = TimeZone(abbreviation: "UTC")
        formatter.dateFormat = "dd MMMM yyyy"
        
        return formatter.string(from: self as Date)
    }
    
}
