//
//  CitySearcherRouter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class CitySearcherRouter {
    weak var presenter: CitySearcherPresenterProtocol?
    weak var view: UIViewController?
}

extension CitySearcherRouter: CitySearcherRouterProtocol {

    func navigateCurrentCityToAddCityWith(currentWeather: CurrentWeather) {
        if let view = view?.presentingViewController as? CurrentCityViewController, let presenter: CurrentCityPresenter = view.presenter as? CurrentCityPresenter {
            presenter.weatherOfCityAdded = currentWeather
            view.presentationControllerDidDismiss()
          }
        view?.dismiss(animated: true, completion: nil)
    }
    
        
}
