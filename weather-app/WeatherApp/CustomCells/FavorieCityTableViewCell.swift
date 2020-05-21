//
//  FavorieCityTableViewCell.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 21/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class FavorieCityTableViewCell: UITableViewCell {

    @IBOutlet weak var cityNameLabel: UILabel!
    static let nibName = "FavorieCityTableViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(cityName: String) {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        self.backgroundView?.backgroundColor = .clear
        cityNameLabel.text = cityName
    }
    
}
