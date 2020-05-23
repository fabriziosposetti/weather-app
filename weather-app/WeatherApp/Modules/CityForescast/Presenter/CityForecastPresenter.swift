//
//  CityForecastPresenter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

typealias ForecastInformation = (city: String, days: [String])

class CityForecastPresenter {
    weak var view: CityForecastViewProtocol?
    var interactor: CityForecastInteractorProtocol?
    var router: CityForecastRouterProtocol?
    
}

extension CityForecastPresenter: CityForecastPresenterProtocol {
    
    func fetchForecast() {
        view?.showLoading()
        interactor?.fetchForecast()
    }
    
    func onForecastFetched(forecast: Forecast) {
        view?.hideLoading()
        var days = [String]()
        for day in forecast.daily {
            days.append(day.getDate())
        }
        
        let forecastInf = ForecastInformation("TENGO qe pasarla", days)
        view?.updateForecastView(forecastInformation: forecastInf)
    }
    
    func onForecastFetchedFailed(error: Error) {
        view?.hideLoading()
        view?.showError(error: error)
    }
    
    
}
