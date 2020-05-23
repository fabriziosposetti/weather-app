//
//  CurrentCityPresenter.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import CoreLocation

typealias FavoriteCityWeather = (name: String, country: String, temp: String, id: Int, lat: Double?, lon: Double?)

class CurrentCityPresenter {
    
    weak var view: CurrentCityViewProtocol?
    var interactor: CurrentCityInteractorProtocol?
    var router: CurrentCityRouterProtocol?
    var weatherOfCityAdded: CurrentWeather?
    var favorites = [FavoriteCityWeather]()
}

extension CurrentCityPresenter: CurrentCityPresenterProtocol {
    
    func favoriteCitySelected(citySelected: FavoriteCityWeather) {
        router?.presentCityForecast(lat: citySelected.lat ?? 0.0,
                                    lon: citySelected.lon ?? 0.0,
                                    cityName: citySelected.name + " ," + citySelected.country)
    }
    
    func removeFavoriteCity(cityId: Int) {
        favorites.removeAll(where: {($0.id == cityId)})
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
            let favoriteCityAdded = FavoriteCityWeather(city.name!, city.country!, "\("--") °", city.id, nil, nil)
            favorites.append(favoriteCityAdded)
        }
        view?.reloadTableView(citiesAdded: favorites)
        if !favorites.isEmpty { interactor?.fetchWeatherBy(citiesId: favoritesCities.map({$0.id})) }
    }
    
    func multipleWeatherFetched(multipleWeather: MultipleWeather) {
        favorites.removeAll()
        for weather in multipleWeather.list {
            let favoriteCityAdded = FavoriteCityWeather(weather.name, weather.sys.country, weather.main.getStringTemp(), weather.id, weather.coord.lat, weather.coord.lon)
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
        let favoriteCityAdded = FavoriteCityWeather(weatherOfCityAdded?.name ?? "", weatherOfCityAdded?.sys.country ?? "", weatherOfCityAdded?.main.getStringTemp() ?? "", weatherOfCityAdded?.id ?? 0, weatherOfCityAdded?.coord.lat, weatherOfCityAdded?.coord.lon)
        favorites.append(favoriteCityAdded)
        view?.reloadTableView(citiesAdded: favorites)
    }
    
}

