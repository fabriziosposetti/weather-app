//
//  CitySearcherProtocols.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

protocol CitySearcherViewProtocol: class {
    func loadCities(citiesToFilter: [CitiesToFilter])
    func showError(error: Error)
    func showLoading()
    func hideLoading()
}

protocol CitySearcherPresenterProtocol: class {
    func fetchCities()
    func onCitiesFetched(cities: [City])
    func citySelected(city: CitiesToFilter)
    func currentWeatherForCitySelected(currentWeather: CurrentWeather)
    func currentWeatherForCitySelectedFailed(error: Error)
    func onCitiesFetchedFailed(error: Error)
}

protocol CitySearcherInteractorProtocol {
    func fetchCities()
    func fetchWeatherToSelectedCity(cityId: Int)
}

protocol CitySearcherRouterProtocol {
    func navigateCurrentCityToAddCityWith(currentWeather: CurrentWeather)
}
