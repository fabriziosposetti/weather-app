//
//  String.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 18/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

extension String {
    
  func localized(withComment comment: String? = nil) -> String {
        return NSLocalizedString(self, comment: comment ?? "")
    }

}
