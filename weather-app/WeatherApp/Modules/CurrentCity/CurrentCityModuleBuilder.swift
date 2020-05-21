//
//  CurrentCityModuleBuilder.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import UIKit

class CurrentCityModuleBuilder {

    static func createModule() -> CurrentCityViewController {
        
        let router = CurrentCityRouter()
        let presenter = CurrentCityPresenter()
        let interactor = CurrentCityInteractor(currentCityRepository: WeatherDataRepository())
       
        let view: CurrentCityViewController  =  CurrentCityViewController.loadXib()
        
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
