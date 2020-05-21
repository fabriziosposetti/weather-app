//
//  CitySearcherBuilder.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

class CitySearcherModuleBuilder {
    
    static func createModule() -> CitySearcherViewController {
           
           let router = CitySearcherRouter()
           let presenter = CitySearcherPresenter()
           let interactor = CitySearcherInteractor(currentCityRepository: WeatherDataRepository())
          
           let view: CitySearcherViewController  =  CitySearcherViewController.loadXib()
           
           presenter.interactor = interactor
           presenter.router = router
           presenter.view = view
           view.presenter = presenter
           interactor.presenter = presenter
           router.presenter = presenter
           router.view = view
        
           return view
       }
}
