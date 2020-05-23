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
    
    func getWeather(cityId: Int) -> Promise<CurrentWeather> {
        let request = Deal.shared.getCurrentWeatherRequest(cityId: cityId)
        return APIClient.request(request: request)
    }
    
    func getWeatherForMultiplesCities(citiesId: [Int]) -> Promise<MultipleWeather> {
        let request = Deal.shared.getMultipleCurrentWeatherRequest(citiesId: citiesId)
        return APIClient.request(request: request)
    }
    
    func getForecastForCity(lat: Double, lon: Double) -> Promise<Forecast> {
        let request = Deal.shared.getForecastRequest(lat: lat, lon: lon)
         return APIClient.request(request: request)
     }
    
}
