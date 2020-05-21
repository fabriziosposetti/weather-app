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

protocol CurrentCityDataSource {
    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather>
}


class WeatherDataRepository: WeatherRepository {
    
    private let openWeatherAPI: CurrentCityDataSource = OpenWeatherAPI.shared
    private var realm : Realm!
    
    init() {
        let realmPath = Bundle.main.url(forResource: "cities", withExtension: "realm")!
        let realmConfiguration = Realm.Configuration(fileURL: realmPath)
        realm = try! Realm(configuration: realmConfiguration)
    }
    
    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather> {
        openWeatherAPI.getWeather(latitude: latitude, longitude: longitude)
    }
    
    func getCities() -> Promise<[City]> {
        return Promise { completion in
            let cities = Array(realm.objects(City.self))
            completion.fulfill(cities)
        }
    }
    
    
}

