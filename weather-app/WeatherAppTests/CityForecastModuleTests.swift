//
//  CityForecastModuleTests.swift
//  WeatherAppTests
//
//  Created by Fabrizio Sposetti on 24/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

import XCTest
import PromiseKit
@testable import Weather

class CityForecastModuleTests: XCTestCase {
    
    let router = CityForecastRouter()
    let presenter = CityForecastPresenter()
    let interactor = CityForecastInteractor(currentCityRepository: MockRepository())
    let view: CityForecastViewController  =  CityForecastViewController.loadXib()
    
    override func setUp() {
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
    }
    
    
    func testForecastInformationRetrieved() {
        let expectation = self.expectation(description: "Forecast expectation")
        
        _ = interactor.cityForecastRepository?.fetchForecast(lat: 0.0, lon: 0.0).done({ forecast in
            XCTAssertNotNil(forecast)
            XCTAssertTrue(forecast.daily.count == 1)
            XCTAssertTrue(forecast.daily.first?.temp.max == 16)
            XCTAssertTrue(forecast.daily.first?.temp.min == 12)
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
}



