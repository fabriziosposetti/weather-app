//
//  CitySearcherPresenter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

class CitySearcherPresenter {
    weak var view: CitySearcherViewProtocol?
    var interactor: CitySearcherInteractorProtocol?
    var router: CitySearcherRouterProtocol?
    
    private var cities: [City]?
    private var filteredCities: [City]?
    
}


extension CitySearcherPresenter: CitySearcherPresenterProtocol {
        
    func fetchCities() {
        interactor?.fetchCities()
    }
    
    
    func onCitiesFetched(cities: [City]) {
        var citiesNames = [String]()
        for city in cities {
            citiesNames.append("\(city.name ?? "") ," + "\(city.country ?? "")")
        }
        view?.loadCities(citiesNames: citiesNames)
    }
    
    func cityNameSelected(name: String) {
        router?.navigateCurrentCityToAddCity(city: name)
    }
    
}
