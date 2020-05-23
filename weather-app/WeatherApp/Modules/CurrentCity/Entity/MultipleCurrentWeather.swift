//
//  MultipleCurrentWeather.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 22/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

struct MultipleWeather: Codable {
    let cnt: Int
    let list: [CurrentWeather]
}
