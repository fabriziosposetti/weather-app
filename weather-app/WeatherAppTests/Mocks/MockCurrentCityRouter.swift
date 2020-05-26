//
//  MockCurrentCityRouter.swift
//  WeatherAppTests
//
//  Created by Fabrizio Sposetti on 26/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Weather

class MockCurrentCityRouter: CurrentCityRouterProtocol {
    weak var presenter: CurrentCityPresenterProtocol?
    weak var view: UIViewController?
    var showCityForecast = false
    var showCitySearcher = false

    
    func presentCitySearcher() {
        showCitySearcher = true
    }
    
    func presentCityForecast(lat: Double, lon: Double, cityName: String) {
        showCityForecast = true
    }
    
}
