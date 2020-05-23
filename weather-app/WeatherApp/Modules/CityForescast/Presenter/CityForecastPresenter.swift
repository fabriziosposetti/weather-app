//
//  CityForecastPresenter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

class CityForecastPresenter {
    weak var view: CityForecastViewProtocol?
    var interactor: CityForecastInteractorProtocol?
    var router: CityForecastRouterProtocol?
    
}

extension CityForecastPresenter: CityForecastPresenterProtocol {
    
}
