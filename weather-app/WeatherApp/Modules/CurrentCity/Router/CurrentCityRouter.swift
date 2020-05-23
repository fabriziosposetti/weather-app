//
//  CurrentCityRouter.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import UIKit

class CurrentCityRouter {
    
    weak var presenter: CurrentCityPresenterProtocol?
    weak var view: UIViewController?
}


extension CurrentCityRouter: CurrentCityRouterProtocol {
    
    func presentCitySearcher() {
        if let view = view {
            let viewController: CitySearcherViewController = CitySearcherModuleBuilder.createModule()
            view.modalPresentationStyle = .fullScreen
            view.present(viewController, animated: true, completion: nil)
        }
    }
    
    func presentCityForecast(lat: Double, lon: Double) {
        if let view = view {
            let viewController: CityForecastViewController = CityForecastBuilder.createModule(lat: lat, lon: lon)
            view.modalPresentationStyle = .fullScreen
            view.present(viewController, animated: true, completion: nil)
        }
    }
    
}
