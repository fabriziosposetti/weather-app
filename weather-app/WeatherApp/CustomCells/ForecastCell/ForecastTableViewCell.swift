//
//  ForecastTableViewCell.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 23/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import UIKit

class ForecastTableViewCell: UITableViewCell {
    
    static let nibName = "ForecastTableViewCell"
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(day: String, maxTemp: String, minTemp: String) {
        self.contentView.backgroundColor = .clear
        self.backgroundColor = .clear
        dayLabel.text = day
        minTempLabel.text = "Min " + minTemp
        maxTempLabel.text = "Max " + maxTemp
    }
    
}
