//
//  WeatherAPI.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit


class OpenWeatherAPI {
    
    static let shared = OpenWeatherAPI()
    
    private init() {}

    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather> {
        let request = Deal.shared.getCurrentWeatherRequest(latitude: latitude, longitude: longitude)
        return APIClient.request(request: request)
    }

    
}
