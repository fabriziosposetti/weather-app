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
    var favoriteCities = [FavoriteCityWeather]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.viewDidLoaded()
    }
    
    private func configureTableView() {
        self.favoritesCitiesTableView.addObserver(self, forKeyPath: "contentSize", options: NSKeyValueObservingOptions.new, context: nil)
        favoritesCitiesTableView.register(UINib(nibName: FavoriteCityTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: FavoriteCityTableViewCell.nibName)
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
        if favoriteCities.count >= 5 {
            showAlert(title: "ATENTION".localized(), message: "MAX_FAV_CITIES".localized(), action: nil)
        } else {
            presenter?.addCityPressed()
        }
    }
    
    @IBAction func showCurrentForecastTapped(_ sender: Any) {
        presenter?.showCurrentCityForecast()
    }
    
    func presentationControllerDidDismiss() {
        presenter?.presentationControllerDidDismiss()
    }
    
}

extension CurrentCityViewController: CurrentCityViewProtocol {
    
    func reloadTableView(citiesAdded: [FavoriteCityWeather]) {
        favoriteCities = citiesAdded
        favoritesCitiesTableView.isHidden = !(favoriteCities.count >= 1)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteCityTableViewCell.nibName, for: indexPath) as! FavoriteCityTableViewCell
        cell.configure(favoriteCityWeather: favoriteCities[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "FAVORITES_CITIES".localized()
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            presenter?.removeFavoriteCity(cityId: favoriteCities[indexPath.row].id)
            favoriteCities.remove(at: indexPath.row)
            reloadTableView(citiesAdded: favoriteCities)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.favoriteCitySelected(citySelected: favoriteCities[indexPath.row])
    }
    
}

extension CurrentCityViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let userLocation = locations.first {
            locationManager.stopUpdatingLocation()
            presenter?.fetchWeatherFrom(latitude: userLocation.coordinate.latitude,
                                        longitude: userLocation.coordinate.longitude)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
    }
    
}

