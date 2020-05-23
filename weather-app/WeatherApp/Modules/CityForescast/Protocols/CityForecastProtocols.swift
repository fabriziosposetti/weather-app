//
//  CityForecastProtocols.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

protocol CityForecastViewProtocol: class {
    func showLoading()
    func hideLoading()
    func showError(error: Error)
    func updateForecastView(forecastInformation: ForecastInformation)
}

protocol CityForecastPresenterProtocol: class {
    func fetchForecast()
    func onForecastFetched(forecast: Forecast)
    func onForecastFetchedFailed(error: Error)
}

protocol CityForecastInteractorProtocol {
    func fetchForecast()
}

protocol CityForecastRouterProtocol {
    
}
