//
//  CurrentCityInteractor.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import CoreLocation
import PromiseKit


protocol WeatherRepository {
    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather>
    func getWeather(cityId: Int) -> Promise<CurrentWeather>
    func getCities() -> Promise<[City]>
    func addWeatherFavoriteCity(weatherFavoriteCity: CurrentWeather)
    func getFavoritesCities() -> Promise<[City]>
}


class CurrentCityInteractor {
    
    weak var presenter: CurrentCityPresenterProtocol?
    var currentCityRepository: WeatherRepository?
    
    init(currentCityRepository: WeatherRepository) {
        self.currentCityRepository = currentCityRepository
    }
    
}

extension CurrentCityInteractor: CurrentCityInteractorProtocol {
    
    func fetchTemperatureFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        _ = currentCityRepository?.getWeather(latitude: "\(latitude)", longitude: "\(longitude)").done ({ weatherModel in
            self.presenter?.weatherFetched(currentWeather: weatherModel)
        }).catch { error in
            self.presenter?.onWeatherFetchedFailed(error: error)
        }
    }
    
    func getFavoritesCities() {
        _ = currentCityRepository?.getFavoritesCities().done({ favoritesCities in
            self.presenter?.favoritesCitiesFetched(favoritesCities: favoritesCities)
        }).catch({ error in
            self.presenter?.onFavoritesCitiesFetchedFailed(error: error)
        })
    }
    
}
