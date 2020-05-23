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
    func getWeatherForMultiplesCities(citiesId: [Int]) -> Promise<MultipleWeather>
    func removeFavoriteCity(cityId: Int)
    func fetchForecast(lat: Double, lon: Double) -> Promise<Forecast>
}


class CurrentCityInteractor {
    
    weak var presenter: CurrentCityPresenterProtocol?
    var currentCityRepository: WeatherRepository?
    
    init(currentCityRepository: WeatherRepository) {
        self.currentCityRepository = currentCityRepository
    }
    
}

extension CurrentCityInteractor: CurrentCityInteractorProtocol {
    
    func removeFavoriteCity(cityId: Int) {
        currentCityRepository?.removeFavoriteCity(cityId: cityId)
    }
    
    
    func fetchWeatherFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
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
    
    func fetchWeatherBy(citiesId: [Int]) {
        _ = currentCityRepository?.getWeatherForMultiplesCities(citiesId: citiesId).done({ multipleWeather in
            self.presenter?.multipleWeatherFetched(multipleWeather: multipleWeather)
            }).catch({ error in
                self.presenter?.onFavoritesCitiesFetchedFailed(error: error)
            })
    }
    
}
