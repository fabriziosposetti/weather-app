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
     
     init(currentCityRepository: WeatherRepository) {
         self.citySearcherRepository = currentCityRepository
     }
}

extension CityForecastInteractor: CityForecastInteractorProtocol {
    
}
