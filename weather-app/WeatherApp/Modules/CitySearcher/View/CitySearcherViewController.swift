//
//  CitySearcherViewController.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit
import RealmSwift

class CitySearcherViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var citiesTableView: UITableView!
    var presenter: CitySearcherPresenterProtocol?
    var citiesNames = [String]()
    var filteredCitiesNames = [String]()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
         presenter?.fetchCities()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        searchBar.delegate = self
    }

}

extension CitySearcherViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredCitiesNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let city = filteredCitiesNames[indexPath.row]
        cell.textLabel?.text = city
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.cityNameSelected(name: filteredCitiesNames[indexPath.row])
    }
    
}



extension CitySearcherViewController: CitySearcherViewProtocol {
    
    func loadCities(citiesNames: [String]) {
        self.citiesNames = citiesNames
        filteredCitiesNames = citiesNames
    }
    
}

extension CitySearcherViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredCitiesNames = searchText.isEmpty ? citiesNames : citiesNames.filter { (item: String) -> Bool in
            return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
        }
        citiesTableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
