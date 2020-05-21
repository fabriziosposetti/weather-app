//
//  CitySearcherProtocols.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

protocol CitySearcherViewProtocol: class {
    func loadCities(citiesNames: [String])
}

protocol CitySearcherPresenterProtocol: class {
    func fetchCities()
    func onCitiesFetched(cities: [City])
    func cityNameSelected(name: String)
}

protocol CitySearcherInteractorProtocol {
    func fetchCities()
}

protocol CitySearcherRouterProtocol {
    func navigateCurrentCityToAddCity(city: String)
}
