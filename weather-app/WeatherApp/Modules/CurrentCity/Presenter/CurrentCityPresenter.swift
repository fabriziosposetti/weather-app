//
//  CurrentCityPresenter.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import CoreLocation

class CurrentCityPresenter {
    
    weak var view: CurrentCityViewProtocol?
    var interactor: CurrentCityInteractorProtocol?
    var router: CurrentCityRouterProtocol?
    var favouritesCities: [String]?

}

extension CurrentCityPresenter: CurrentCityPresenterProtocol {

    func viewDidLoaded() {
        view?.determineCurrentLocation()
        print(favouritesCities)
    }
    
    func fetchWeatherFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        interactor?.fetchTemperatureFrom(latitude: latitude, longitude: longitude)
    }
    
    
    func weatherFetched(currentWeather: CurrentWeather) {
        let temp = Int(round(currentWeather.main.temp))
        let city = currentWeather.name
        view?.updateTemperatureLabel(temperature: "\(temp) °")
        view?.updateCurrentCityLabel(city: city)
    }
    
    func onWeatherFetchedFailed(error: Error) {
        view?.showError(error: error)
    }
    
    func addCityPressed() {
        router?.presentCitySearcher()
    }
    
}

