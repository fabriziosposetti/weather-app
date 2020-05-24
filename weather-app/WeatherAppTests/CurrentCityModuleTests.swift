//
//  WeatherAppTests.swift
//  WeatherAppTests
//
//  Created by Fabrizio Sposetti on 24/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import XCTest
import PromiseKit
@testable import Weather

class CurrentCityModuleTests: XCTestCase {
    
    let router = CurrentCityRouter()
    let presenter = CurrentCityPresenter()
    let interactor = CurrentCityInteractor(currentCityRepository: MockRepository())
    let view: CurrentCityViewController  =  CurrentCityViewController.loadXib()
    
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
    
    func testMockWeatherShouldHave10Temp() {
        
        let expectation = self.expectation(description: "Current Weather expectation")
                
        _ = interactor.currentCityRepository?.getWeather(latitude: "0", longitude: "0").done({ weather in
            XCTAssertNotNil(weather)
            XCTAssertTrue(10 == weather.main.temp)
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testMockWeatherShouldHaveCordobaCity() {
        
        let expectation = self.expectation(description: "Current Weather expectation")
        
        _ = interactor.currentCityRepository?.getWeather(latitude: "0", longitude: "0").done({ weather in
            XCTAssertNotNil(weather)
            XCTAssertTrue("Córdoba" == weather.name)
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testMockFavCitiesCountShoudBe2() {
        
        let expectation = self.expectation(description: "Fav cities expectation")
        
        _ = interactor.currentCityRepository?.getFavoritesCities().done({ favCities in
            XCTAssertNotNil(favCities)
            XCTAssertTrue(favCities.count == 2)
            XCTAssertTrue(self.view.favoriteCities.count == 2)
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testCurrentCurrentCityLabelShouldBeCordoba() {
        let expectation = self.expectation(description: "Current Weather expectation")

        presenter.viewDidLoaded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.view.currentCity.text == "Córdoba")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
    func testCurrentTempLabelShouldBe10() {
        let expectation = self.expectation(description: "Current Weather expectation")

        presenter.viewDidLoaded()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.view.currentTemp.text == "10 °")
            expectation.fulfill()
        }
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}



