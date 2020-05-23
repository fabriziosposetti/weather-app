// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - Welcome
struct CurrentWeather: Codable {
    let weather: [Weather]
    let main: Main
    let sys: Sys
    let name: String
    let id: Int
    let coord: Coord
}

struct Coord: Codable {
    let lon: Double
    let lat: Double
}

// MARK: - Main
struct Main: Codable  {
    let temp: Double
    let pressure, humidity: Int
    
    func getStringTemp() -> String {
        return "\(Int(round(temp))) °"
    }
}

// MARK: - Sys
struct Sys: Codable  {
    let country: String
}

// MARK: - Weather
struct Weather: Codable  {
    let main: String
}

