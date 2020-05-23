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
    var days = [String]()
    
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
        days = forecastInformation.days
        daysTableView.isHidden = false
        daysTableView.reloadData()
    }
    
}

extension CityForecastViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //         let cell = tableView.dequeueReusableCell(withIdentifier: FavorieCityTableViewCell.nibName, for: indexPath) as! FavorieCityTableViewCell
        let cell = UITableViewCell()
        cell.textLabel?.text = days[indexPath.row]
        return cell
    }
}
