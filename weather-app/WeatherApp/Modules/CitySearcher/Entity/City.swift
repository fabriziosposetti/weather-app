//
//  City.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 19/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import RealmSwift

class City: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var country: String?
    @objc dynamic var isFavorite = false
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

