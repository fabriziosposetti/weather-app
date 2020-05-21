//
//  CurrentCityViewController.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 17/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit
import CoreLocation

class CurrentCityViewController: UIViewController {
    
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentCity: UILabel!
    var presenter: CurrentCityPresenterProtocol?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
        
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        presenter?.addCityPressed()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.viewDidLoaded()
    }
    
}

extension CurrentCityViewController: CurrentCityViewProtocol {
    func determineCurrentLocation() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.requestLocation()
        }
    }
    
    func updateTemperatureLabel(temperature: String) {
        currentTemp.text = temperature
    }
    
    func updateCurrentCityLabel(city: String) {
        currentCity.text = city
    }
    
    func showError(error: Error) {
        showAlert(with: error)
    }
    
}

extension CurrentCityViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            locationManager.stopUpdatingLocation()
//            presenter?.fetchWeatherFrom(latitude: userLocation.coordinate.latitude,
//                                        longitude: userLocation.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
}

