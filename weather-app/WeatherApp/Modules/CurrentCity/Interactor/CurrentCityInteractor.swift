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
    func getCities() -> Promise<[City]>
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
    
    
}
