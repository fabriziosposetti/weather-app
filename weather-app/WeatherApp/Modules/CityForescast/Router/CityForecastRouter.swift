//
//  CityForecastRouter.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import UIKit

class CityForecastRouter {
    weak var presenter: CityForecastPresenterProtocol?
    weak var view: UIViewController?
}

extension CityForecastRouter: CityForecastRouterProtocol {
    
}
