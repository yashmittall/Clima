//
//  WeatherData.swift
//  Clima
//
//  Created by Yash Mittal on 16/05/20.
//

import Foundation
import CoreLocation

struct WeatherData: Codable{
    let name: String
    let main: Main
    let weather: [Weather]
    let coord: Coord
}

struct Main: Codable {
    let temp: Double
}

struct Weather: Codable{
    let description: String
    let id: Int
}

struct Coord: Codable{
    let lat: CLLocationDegrees
    let lon: CLLocationDegrees
}

