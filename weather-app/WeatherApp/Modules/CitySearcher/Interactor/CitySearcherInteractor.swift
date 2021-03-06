//
//  CitySearcherInteractyor.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

class CitySearcherInteractor {
    weak var presenter: CitySearcherPresenterProtocol?
    var citySearcherRepository: WeatherRepository?
    
    init(currentCityRepository: WeatherRepository) {
        self.citySearcherRepository = currentCityRepository
    }

}

extension CitySearcherInteractor: CitySearcherInteractorProtocol {
    
    func fetchWeatherToSelectedCity(cityId: Int) {
        _ = citySearcherRepository?.getWeather(cityId: cityId).done({ currentWeather in
            self.citySearcherRepository?.addWeatherFavoriteCity(weatherFavoriteCity: currentWeather)
            self.presenter?.currentWeatherForCitySelected(currentWeather: currentWeather)
        }).catch({ error in
            self.presenter?.currentWeatherForCitySelectedFailed(error: error)
        })
    }
    
    func fetchCities() {
        _  = citySearcherRepository?.getCities().done({ cities in
            self.presenter?.onCitiesFetched(cities: cities)
        }).catch({ error in
            self.presenter?.onCitiesFetchedFailed(error: error)
            
        })
    }
    
    
}
