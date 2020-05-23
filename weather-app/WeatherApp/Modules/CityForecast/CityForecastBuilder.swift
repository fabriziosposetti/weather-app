//
//  CityForecastBuilder.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

class CityForecastBuilder {
    static func createModule(lat: Double, lon: Double, cityName: String) -> CityForecastViewController{
        
        let router = CityForecastRouter()
        let presenter = CityForecastPresenter()
        let interactor = CityForecastInteractor(currentCityRepository: WeatherDataRepository())
       
        let view: CityForecastViewController  =  CityForecastViewController.loadXib()
        
        presenter.interactor = interactor
        presenter.router = router
        presenter.view = view
        view.presenter = presenter
        interactor.presenter = presenter
        router.presenter = presenter
        router.view = view
        interactor.lat = lat
        interactor.lon = lon
        presenter.cityName = cityName

        return view
    }
    
}
