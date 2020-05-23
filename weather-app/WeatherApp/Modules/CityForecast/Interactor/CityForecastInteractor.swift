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
    var citySearcherRepository: WeatherRepository?
    var lat: Double?
    var lon: Double?
    
    init(currentCityRepository: WeatherRepository) {
        self.citySearcherRepository = currentCityRepository
    }
}

extension CityForecastInteractor: CityForecastInteractorProtocol {
    
    func fetchForecast() {
        if let lat = lat, let lon = lon {
           _ = citySearcherRepository?.fetchForecast(lat: lat, lon: lon).done({ forecast in
            self.presenter?.onForecastFetched(forecast: forecast)
           }).catch({ error in
            self.presenter?.onForecastFetchedFailed(error: error)
           })
        }
    }
    
    
}
