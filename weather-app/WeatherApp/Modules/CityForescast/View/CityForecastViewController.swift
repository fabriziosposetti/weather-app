//
//  CityForecastViewController.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class CityForecastViewController: UIViewController {
    
    var presenter: CityForecastPresenterProtocol?


    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

extension CityForecastViewController: CityForecastViewProtocol {
    
}
