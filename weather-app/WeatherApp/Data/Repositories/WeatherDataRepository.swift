//
//  CurrentCityRepository.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 18/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON
import RealmSwift

class WeatherDataRepository: WeatherRepository {
    
    private let openWeatherAPI = OpenWeatherAPI.shared
    private var realm : Realm!
    
    init() {
        var config = Realm.Configuration()
        config.fileURL = config.fileURL!.deletingLastPathComponent().appendingPathComponent("cities.realm")
        realm = try! Realm(configuration: config)
    }
    
    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather> {
        openWeatherAPI.getWeather(latitude: latitude, longitude: longitude)
    }
    
    func getWeather(cityId: Int) -> Promise<CurrentWeather> {
        openWeatherAPI.getWeather(cityId: cityId)
    }
    
    func getCities() -> Promise<[City]> {
        return Promise { completion in
            let cities = Array(realm.objects(City.self))
            completion.fulfill(cities)
        }
    }
    
    func addWeatherFavoriteCity(weatherFavoriteCity: CurrentWeather) {
        let cities: [City] =  Array(realm.objects(City.self).filter("id = %@", weatherFavoriteCity.id))
        if let city = cities.first {
            do {
                try realm.write {
                    city.isFavorite = true
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
    func getFavoritesCities() -> Promise<[City]> {
        return Promise { completion in
            let cities: [City] =  Array(realm.objects(City.self).filter("isFavorite = %@", true))
            completion.fulfill(cities)
        }
    }
    
    func getWeatherForMultiplesCities(citiesId: [Int]) -> Promise<MultipleWeather> {
        openWeatherAPI.getWeatherForMultiplesCities(citiesId: citiesId)
    }
    
    func removeFavoriteCity(cityId: Int) {
        let cities: [City] = Array(realm.objects(City.self).filter("id = %@", cityId))
        if let city = cities.first {
            do {
                try realm.write {
                    city.isFavorite = false
                }
            } catch (let error) {
                print(error.localizedDescription)
            }
        }
    }
    
}


