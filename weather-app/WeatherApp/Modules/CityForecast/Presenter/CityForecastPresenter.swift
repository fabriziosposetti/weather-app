//
//  CityForecastPresenter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

typealias WeatherInformationPerDay = (day: String, max: String, min: String)
typealias ForecastInformation = (city: String, forecastForDay: [WeatherInformationPerDay])

class CityForecastPresenter {
    weak var view: CityForecastViewProtocol?
    var interactor: CityForecastInteractorProtocol?
    var router: CityForecastRouterProtocol?
    var cityName: String?
}

extension CityForecastPresenter: CityForecastPresenterProtocol {
    
    func fetchForecast() {
        view?.showLoading()
        interactor?.fetchForecast()
    }
    
    func onForecastFetched(forecast: Forecast) {
        view?.hideLoading()
        var forecastForDay = [WeatherInformationPerDay]()
        for day in forecast.daily {
            forecastForDay.append((day.getDate(), "\(day.temp.getStringMaxTemp())", "\(day.temp.getStringMinTemp())"))
        }
        
        let forecastInf = ForecastInformation(cityName ?? "", forecastForDay)
        view?.updateForecastView(forecastInformation: forecastInf)
    }
    
    func onForecastFetchedFailed(error: Error) {
        view?.hideLoading()
        view?.showError(error: error)
    }
    
    
}
