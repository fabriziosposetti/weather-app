//
//  CitySearcherTests.swift
//  WeatherAppTests
//
//  Created by Fabrizio Sposetti on 24/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import XCTest
import PromiseKit
@testable import Weather

class CitySearcherTests: XCTestCase {
    
    let router = CitySearcherRouter()
    let presenter = CitySearcherPresenter()
    let interactor = CitySearcherInteractor(currentCityRepository: MockRepository())
    let view: CitySearcherViewController  =  CitySearcherViewController.loadXib()
    
    override func setUp() {
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        view.loadViewIfNeeded()
    }
    
    
    func testCitiesInformationRetrieved() {
        
        let expectation = self.expectation(description: "Cities expectation")
        
        _ = interactor.citySearcherRepository?.getCities().done({ cities in
            XCTAssertNotNil(cities)
            XCTAssertTrue(cities.count == 2)
            XCTAssertTrue(cities.first?.name == "city1")
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
    func testGetWeatherInformationRetrieved() {
        
        let expectation = self.expectation(description: "Weather expectation")
        
        _ = interactor.citySearcherRepository?.getWeather(cityId: 1).done({ weather in
            XCTAssertNotNil(weather)
            XCTAssertTrue(weather.name == "Bs As")
            XCTAssertTrue(weather.main.temp == 30)
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    
}
