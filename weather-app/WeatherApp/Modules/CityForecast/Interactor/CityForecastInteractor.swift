//
//  CityForecastInteractor.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

class CityForecastInteractor {
    weak var presenter: CityForecastPresenterProtocol?
    var cityForecastRepository: WeatherRepository?
    var lat: Double?
    var lon: Double?
    
    init(currentCityRepository: WeatherRepository) {
        self.cityForecastRepository = currentCityRepository
    }
}

extension CityForecastInteractor: CityForecastInteractorProtocol {
    
    func fetchForecast() {
        if let lat = lat, let lon = lon {
           _ = cityForecastRepository?.fetchForecast(lat: lat, lon: lon).done({ forecast in
            self.presenter?.onForecastFetched(forecast: forecast)
           }).catch({ error in
            self.presenter?.onForecastFetchedFailed(error: error)
           })
        }
    }
    
    
}
