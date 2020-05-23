//
//  CityForecastViewController.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class CityForecastViewController: UIViewController {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var daysTableView: UITableView!
    var informationPerDay = [WeatherInformationPerDay]()
    
    var presenter: CityForecastPresenterProtocol?
    let activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        presenter?.fetchForecast()
    }
    
    func configureTableView() {
        daysTableView.delegate = self
        daysTableView.dataSource = self
        daysTableView.tableFooterView = UIView()
        daysTableView.register(UINib(nibName: ForecastTableViewCell.nibName, bundle: nil), forCellReuseIdentifier: ForecastTableViewCell.nibName)
    }
    
}

extension CityForecastViewController: CityForecastViewProtocol {
    
    func showError(error: Error) {
        showAlert(with: error)
    }
    
    func showLoading() {
        showActivityIndicator(activityIndicator: activityIndicator)
    }
    
    func hideLoading() {
        stopActivityIndicator(activityIndicator: activityIndicator)
    }
    
    func updateForecastView(forecastInformation: ForecastInformation) {
        cityLabel.text = forecastInformation.city
        informationPerDay = forecastInformation.forecastForDay
        daysTableView.isHidden = false
        daysTableView.reloadData()
    }
    
}

extension CityForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return informationPerDay.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.nibName, for: indexPath) as! ForecastTableViewCell
        cell.configure(day: informationPerDay[indexPath.row].day, maxTemp: informationPerDay[indexPath.row].max, minTemp: informationPerDay[indexPath.row].min)
        return cell
    }
}
