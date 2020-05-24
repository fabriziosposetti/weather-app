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

class WeatherAppTests: XCTestCase {
    
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
            expectation.fulfill()
        })
        
        self.waitForExpectations(timeout: 10.0, handler: nil)
    }
    
}


class MockRepository: WeatherRepository {
    
    func getWeather(cityId: Int) -> Promise<CurrentWeather> {
        return Promise.init(error: AppWeatherError.internalServerError)
    }
    
    func getCities() -> Promise<[City]> {
        return Promise.init(error: AppWeatherError.internalServerError)
    }
    
    func addWeatherFavoriteCity(weatherFavoriteCity: CurrentWeather) {
        
    }
    
    func getFavoritesCities() -> Promise<[City]> {
        return Promise { completion in
            var favCities = [City]()
            let city1 = City()
            city1.name = "city1"
            city1.country = "country1"
            let city2 = City()
            city1.name = "city2"
            city1.country = "country2"
            
            favCities.append(city1)
            favCities.append(city2)
            completion.fulfill(favCities)
        }
    }
    
    func getWeatherForMultiplesCities(citiesId: [Int]) -> Promise<MultipleWeather> {
        return Promise.init(error: AppWeatherError.internalServerError)
    }
    
    func removeFavoriteCity(cityId: Int) {
        
    }
    
    func fetchForecast(lat: Double, lon: Double) -> Promise<Forecast> {
        return Promise.init(error: AppWeatherError.internalServerError)
    }
    
    func getWeather(latitude: String, longitude: String) -> Promise<CurrentWeather> {
        return Promise { completion in
            let main = Main(temp: 10, pressure: 1, humidity: 1)
            let weather = Weather(main: "")
            let sys = Sys(country: "")
            let cord = Coord(lon: 0, lat: 0)
            let current = CurrentWeather(weather: [weather], main: main, sys: sys, name: "Córdoba", id: 1, coord: cord)
            completion.fulfill(current)
        }
    }
    
}
