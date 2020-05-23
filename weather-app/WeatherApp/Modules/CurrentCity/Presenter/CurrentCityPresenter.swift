//
//  CurrentCityPresenter.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import CoreLocation

typealias FavoriteCityWeather = (name: String, country: String, temp: String, id: Int)

class CurrentCityPresenter {
    
    weak var view: CurrentCityViewProtocol?
    var interactor: CurrentCityInteractorProtocol?
    var router: CurrentCityRouterProtocol?
    var weatherOfCityAdded: CurrentWeather?
    var favorites = [FavoriteCityWeather]()
}

extension CurrentCityPresenter: CurrentCityPresenterProtocol {
    
    func removeFavoriteCity(cityId: Int) {
        interactor?.removeFavoriteCity(cityId: cityId)
    }
    
    func viewDidLoaded() {
        view?.determineCurrentLocation()
        interactor?.getFavoritesCities()
    }
    
    func fetchWeatherFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        interactor?.fetchWeatherFrom(latitude: latitude, longitude: longitude)
    }
    
    func weatherFetched(currentWeather: CurrentWeather) {
        let temp = Int(round(currentWeather.main.temp))
        let city = currentWeather.name
        view?.updateTemperatureLabel(temperature: "\(temp) °")
        view?.updateCurrentCityLabel(city: city)
    }
    
    func favoritesCitiesFetched(favoritesCities: [City]) {
        for city in favoritesCities {
            let favoriteCityAdded = FavoriteCityWeather(city.name!, city.country!, "\("--") °", city.id)
            favorites.append(favoriteCityAdded)
        }
        view?.reloadTableView(citiesAdded: favorites)
        let ids = favoritesCities.map({$0.id})
     //   interactor?.fetchWeatherBy(citiesId: ids)
    }
    
    func multipleWeatherFetched(multipleWeather: MultipleWeather) {
        favorites.removeAll()
        for weather in multipleWeather.list {
            let temp = Int(round(weather.main.temp))
            let favoriteCityAdded = FavoriteCityWeather(weather.name, weather.sys.country, "\(temp) °", weather.id)
            favorites.append(favoriteCityAdded)
        }
        view?.reloadTableView(citiesAdded: favorites)
    }
    
    func onFavoritesCitiesFetchedFailed(error: Error) {
        view?.showError(error: error)
    }
    
    func onWeatherFetchedFailed(error: Error) {
        view?.showError(error: error)
    }
    
    func addCityPressed() {
        router?.presentCitySearcher()
    }
    
    func presentationControllerDidDismiss() {
        let temp = Int(round(weatherOfCityAdded?.main.temp ?? 0))
        let favoriteCityAdded = FavoriteCityWeather(weatherOfCityAdded?.name ?? "", weatherOfCityAdded?.sys.country ?? "", "\(temp) °", weatherOfCityAdded?.id ?? 0)
        favorites.append(favoriteCityAdded)
        view?.reloadTableView(citiesAdded: favorites)
    }
    
}

