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
    func reloadTableView(cityAdded: String)
}

protocol CurrentCityPresenterProtocol: class {
    func viewDidLoaded()
    func fetchWeatherFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    func weatherFetched(currentWeather: CurrentWeather)
    func onWeatherFetchedFailed(error: Error)
    func addCityPressed()
    func presentationControllerDidDismiss()
}

protocol CurrentCityInteractorProtocol {
    func fetchTemperatureFrom(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
    
}

protocol CurrentCityRouterProtocol {
    func presentCitySearcher()
}
