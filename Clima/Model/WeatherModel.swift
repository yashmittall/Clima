//
//  WeatherModel.swift
//  Clima
//
//  Created by Yash Mittal on 16/05/20.
//

import Foundation
import CoreLocation

struct WeatherModel {
    let conditionId: Int
    let cityName: String
    let temperature: Double
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
    
    var temperatureString: String{
        return String(format: "%.1f", temperature)
    }
    
    var conditionName: String{   //COMPUTED PROPERTY always return something
        switch conditionId {
          case 200...232:
              return "cloud.bolt"
          case 300...321:
              return "cloud.drizzle"
          case 500...501:
              return "cloud.rain"
          case 502...531:
              return "cloud.heavyrain"
          case 600...622:
              return "cloud.snow"
          case 701...781:
              return "cloud.fog"
          case 800:
              return "sun.max"
          case 801...804:
              return "cloud.bolt"
          default:
              return "cloud"
          }
        }
    
    
    
}
