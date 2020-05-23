//
//  Deal.swift
//  weather-app
//
//  Created by Fabrizio Sposetti on 18/05/2020.
//  Copyright © 2020 Fabrizio Sposetti. All rights reserved.
//

import Foundation

struct KeyDict {
    let weatherAPIKey: String!
}


class Deal {
    
    static let shared = Deal()
    
    private init() {}
    
    private var keys: NSDictionary?
    
    func getKey() -> KeyDict {
        if let path = Bundle.main.path(forResource: "Apikeys", ofType: "plist") {
            self.keys = NSDictionary(contentsOfFile: path)!
        }
        
        if let data = keys {
            return KeyDict(weatherAPIKey: (data["weatherApiKey"] as! String))
        } else {
            return KeyDict(weatherAPIKey: "")
        }
    }
    
    func getCurrentWeatherRequest(latitude: String, longitude: String) -> URLRequest {
        let dict: KeyDict = self.getKey()
        let queryItems = [URLQueryItem(name: "lat", value: "\(latitude)"),
                          URLQueryItem(name: "lon", value: "\(longitude)"),
                          URLQueryItem(name: "appid", value: "\(dict.weatherAPIKey!)"),
                          URLQueryItem(name: "units", value: "metric")]
        
        var urlComps = URLComponents(string: K.baseURL + "/weather")!
        
        urlComps.queryItems = queryItems
        
        let url = (urlComps.url!)
        let request = URLRequest(url: url)
        return request
    }
    
    func getCurrentWeatherRequest(cityId: Int) -> URLRequest {
        let dict: KeyDict = self.getKey()
        let queryItems = [URLQueryItem(name: "id", value: "\(cityId)"),
                          URLQueryItem(name: "appid", value: "\(dict.weatherAPIKey!)"),
                          URLQueryItem(name: "units", value: "metric")]
        
        var urlComps = URLComponents(string: K.baseURL + "/weather")!
        
        urlComps.queryItems = queryItems
        
        let url = (urlComps.url!)
        let request = URLRequest(url: url)
        return request
    }
    
    func getMultipleCurrentWeatherRequest(citiesId: [Int]) -> URLRequest {
        let dict: KeyDict = self.getKey()
        var queryIds = String()
        var queryItems = [URLQueryItem(name: "appid", value: "\(dict.weatherAPIKey!)"),
                          URLQueryItem(name: "units", value: "metric")]
        
        for cityId in citiesId {
            if citiesId.last == cityId { queryIds.append(contentsOf: "\(cityId)") }
            else {
                queryIds.append(contentsOf: "\(cityId),")
            }
        }
        queryItems.append(URLQueryItem(name: "id", value: "\(queryIds)"))
        var urlComps = URLComponents(string: K.baseURL + "/group")!
        
        urlComps.queryItems = queryItems
        
        let url = (urlComps.url!)
        let request = URLRequest(url: url)
        return request
    }
    
}
