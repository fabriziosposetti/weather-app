//
//  MockRepository.swift
//  WeatherAppTests
//
//  Created by Fabrizio Sposetti on 24/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import PromiseKit
@testable import Weather

class MockRepository: WeatherRepository {
    
    func getWeather(cityId: Int) -> Promise<CurrentWeather> {
        return Promise { completion in
            let main = Main(temp: 30, pressure: 1, humidity: 1)
            let weather = Weather(main: "")
            let sys = Sys(country: "")
            let cord = Coord(lon: 0, lat: 0)
            let current = CurrentWeather(weather: [weather], main: main, sys: sys, name: "Bs As", id: 1, coord: cord)
            completion.fulfill(current)
        }
    }
    
    func getCities() -> Promise<[City]> {
        return Promise { completion in
            var cities = [City]()
            let city1 = City()
            city1.name = "city1"
            city1.country = "country1"
            let city2 = City()
            city2.name = "city2"
            city2.country = "country2"
            
            cities.append(city1)
            cities.append(city2)
            completion.fulfill(cities)
        }
    }
    
    func addWeatherFavoriteCity(weatherFavoriteCity: CurrentWeather) {
        
    }
    
    func getFavoritesCities() -> Promise<[City]> {
        return Promise { completion in
            var favCities = [City]()
            let city1 = City()
            city1.name = "city1"
            city1.country = "country1"
            let city2 = City()
            city2.name = "city2"
            city2.country = "country2"
            
            favCities.append(city1)
            favCities.append(city2)
            completion.fulfill(favCities)
        }
    }
    
    func getWeatherForMultiplesCities(citiesId: [Int]) -> Promise<MultipleWeather> {
        return Promise.init(error: AppWeatherError.internalServerError)
    }
    
    func removeFavoriteCity(cityId: Int) {
        
    }
    
    func fetchForecast(lat: Double, lon: Double) -> Promise<Forecast> {
        return Promise { completion in
            let temp = Temp(day: 0.0, min: 12, max: 16, night: 0.0, eve: 0.0, morn: 0.0)
            let daily = Daily(dt: 1, temp: temp)
            var dailys = [Daily]()
            dailys.append(daily)
            let forecast = Forecast(timezone: "", daily: dailys)
            completion.fulfill(forecast)
        }
    }
    
    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather> {
        return Promise { completion in
            let main = Main(temp: 10, pressure: 1, humidity: 1)
            let weather = Weather(main: "")
            let sys = Sys(country: "")
            let cord = Coord(lon: 0, lat: 0)
            let current = CurrentWeather(weather: [weather], main: main, sys: sys, name: "Córdoba", id: 1, coord: cord)
            completion.fulfill(current)
        }
    }
    
}
