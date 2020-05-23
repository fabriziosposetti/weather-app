//
//  CurrentCityProtocols.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import CoreLocation

protocol CurrentCityViewProtocol: class {
    func determineCurrentLocation()
    func updateTemperatureLabel(temperature: String)
    func updateCurrentCityLabel(city: String)
    func showError(error: Error)
    func reloadTableView(citiesAdded: [FavoriteCityWeather])
}

protocol CurrentCityPresenterProtocol: class {
    func viewDidLoaded()
    func fetchWeatherFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func weatherFetched(currentWeather: CurrentWeather)
    func onWeatherFetchedFailed(error: Error)
    func addCityPressed()
    func presentationControllerDidDismiss()
    func favoritesCitiesFetched(favoritesCities: [City])
    func onFavoritesCitiesFetchedFailed(error: Error)
    func multipleWeatherFetched(multipleWeather: MultipleWeather)
    func removeFavoriteCity(cityId: Int)
    func favoriteCitySelected(citySelected: FavoriteCityWeather)
    func showCurrentCityForecast()
}

protocol CurrentCityInteractorProtocol {
    func fetchWeatherFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func getFavoritesCities()
    func fetchWeatherBy(citiesId: [Int])
    func removeFavoriteCity(cityId: Int)
}

protocol CurrentCityRouterProtocol {
    func presentCitySearcher()
    func presentCityForecast(lat: Double, lon: Double, cityName: String)
}
