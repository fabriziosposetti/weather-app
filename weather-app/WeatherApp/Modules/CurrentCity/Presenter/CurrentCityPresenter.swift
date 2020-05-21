//
//  CurrentCityPresenter.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import CoreLocation

typealias FavoriteCityWeather = (name: String, country: String, temp: String)

class CurrentCityPresenter {
    
    weak var view: CurrentCityViewProtocol?
    var interactor: CurrentCityInteractorProtocol?
    var router: CurrentCityRouterProtocol?
    var weatherOfCityAdded: CurrentWeather?

}

extension CurrentCityPresenter: CurrentCityPresenterProtocol {
    
    func viewDidLoaded() {
        view?.determineCurrentLocation()
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
    
    func presentationControllerDidDismiss() {
        let temp = Int(round(weatherOfCityAdded?.main.temp ?? 0))

        let favoriteCityAdded = FavoriteCityWeather(weatherOfCityAdded?.name ?? "", weatherOfCityAdded?.sys.country ?? "", "\(temp) °")
        view?.reloadTableView(cityAdded: favoriteCityAdded)
    }
    
}

