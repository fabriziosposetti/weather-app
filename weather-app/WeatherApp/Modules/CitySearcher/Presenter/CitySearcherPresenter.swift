//
//  CitySearcherPresenter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

typealias CitiesToFilter = (String, Int)

class CitySearcherPresenter {
    weak var view: CitySearcherViewProtocol?
    var interactor: CitySearcherInteractorProtocol?
    var router: CitySearcherRouterProtocol?
}

extension CitySearcherPresenter: CitySearcherPresenterProtocol {
    
    func fetchCities() {
        interactor?.fetchCities()
    }
    
    func onCitiesFetched(cities: [City]) {
        var citiesToFilter = [CitiesToFilter]()
        for city in cities {
            citiesToFilter.append(("\(city.name ?? "") ," + "\(city.country ?? "")", city.id))
        }
        view?.loadCities(citiesToFilter: citiesToFilter)
    }
    
    func citySelected(city: CitiesToFilter) {
        interactor?.fetchWeatherToSelectedCity(cityId: city.1)
    }
    
    func currentWeatherForCitySelected(currentWeather: CurrentWeather) {
        router?.navigateCurrentCityToAddCityWith(currentWeather: currentWeather)
    }
    
}
