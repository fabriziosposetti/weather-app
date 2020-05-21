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
    
    @IBOutlet weak var tableViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var favoritesCitiesTableView: UITableView!
    @IBOutlet weak var currentTemp: UILabel!
    @IBOutlet weak var currentCity: UILabel!
    var presenter: CurrentCityPresenterProtocol?
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var favoriteCities = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoaded()
    }
    
    private func configureTableView() {
        self.favoritesCitiesTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        favoritesCitiesTableView.register(UINib(nibName: FavorieCityTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: "FavorieCityTableViewCell")
        favoritesCitiesTableView.delegate = self
        favoritesCitiesTableView.dataSource = self
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        favoritesCitiesTableView.layer.removeAllAnimations()
        tableViewHeightConstraint.constant = favoritesCitiesTableView.contentSize.height
        UIView.animate(withDuration: 0.5) {
            self.updateViewConstraints()
        }
        
    }
    
    @IBAction func addBtnTapped(_ sender: UIButton) {
        presenter?.addCityPressed()
    }
    
    func presentationControllerDidDismiss() {
        presenter?.presentationControllerDidDismiss()
    }
    
    
}

extension CurrentCityViewController: CurrentCityViewProtocol {
    
    func reloadTableView(cityAdded: String) {
        favoritesCitiesTableView.isHidden = false
        favoriteCities.append(cityAdded)
        favoritesCitiesTableView.reloadData()
        
    }
    
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

extension CurrentCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavorieCityTableViewCell", for: indexPath) as! FavorieCityTableViewCell
        cell.configure(cityName: favoriteCities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FAVORITES_CITIES".localized()
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

