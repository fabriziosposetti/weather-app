//
//  AppError.swift
//  WeatherApp
//
//  Created by Fabrizio Sposetti on 18/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation
import SwiftyJSON


public enum AppWeatherError: String, Error {
    case generic = "Se ha producido un error inesperado. Por favor, inténtelo nuevamente más tarde."
    case notConnectedToInternet = "Parece que no tienes conexión a internet."
    case internalServerError = "No se pudo realizar la acción. Por favor, intente más tarde."
    
}

extension AppWeatherError: LocalizedError {
    
    public var errorDescription: String? {
        return self.rawValue.localized()
    }
}

extension AppWeatherError {
    
    public init(error: JSON) {
        let code = Int(error["cod"].stringValue)
        
        switch code {
        case 400: self = AppWeatherError.generic
        case 500: self = AppWeatherError.internalServerError
        default: self = AppWeatherError.generic
        }
    }
    
}
