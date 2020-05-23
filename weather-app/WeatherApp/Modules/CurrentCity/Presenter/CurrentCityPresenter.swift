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
    
    func favoriteCitySelected(cityId: Int) {
        router?.presentCityForecast(cityId: cityId)
    }
    
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
        view?.updateTemperatureLabel(temperature: currentWeather.main.getStringTemp())
        view?.updateCurrentCityLabel(city: currentWeather.name)
    }
    
    func favoritesCitiesFetched(favoritesCities: [City]) {
        for city in favoritesCities {
            let favoriteCityAdded = FavoriteCityWeather(city.name!, city.country!, "\("--") °", city.id)
            favorites.append(favoriteCityAdded)
        }
        view?.reloadTableView(citiesAdded: favorites)
        if !favorites.isEmpty { interactor?.fetchWeatherBy(citiesId: favoritesCities.map({$0.id})) }
    }
    
    func multipleWeatherFetched(multipleWeather: MultipleWeather) {
        favorites.removeAll()
        for weather in multipleWeather.list {
            let favoriteCityAdded = FavoriteCityWeather(weather.name, weather.sys.country, weather.main.getStringTemp(), weather.id)
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
        let favoriteCityAdded = FavoriteCityWeather(weatherOfCityAdded?.name ?? "", weatherOfCityAdded?.sys.country ?? "", weatherOfCityAdded?.main.getStringTemp() ?? "", weatherOfCityAdded?.id ?? 0)
        favorites.append(favoriteCityAdded)
        view?.reloadTableView(citiesAdded: favorites)
    }
    
}

