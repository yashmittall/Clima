//
//  WeatherManager.swift
//  Clima
//
//  Created by Yash Mittal on 14/05/20.
//

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
    func didFailWithError(error: Error)
}
struct WeatherManager: WeatherManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel){
        print(weather.temperatureString)
    }
    
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=/enter your api key/&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String){
        if let cityName = cityName.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed){
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString) //adding percentage encoding is for cities having spacs in name
        }
    }
    
    func fetchWeather(latitude: CLLocationDegrees,longitude: CLLocationDegrees){
        let urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
        }
        
    
    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil{
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data{
                    if let weather = self.parseJSON(safeData){
                        self.delegate?.didUpdateWeather(self, weather: weather)
                        
                       
                    }
                   
                }
            }
            task.resume()
        }
    }
        
        func parseJSON(_ weatherData: Data) -> WeatherModel? {
            let decoder = JSONDecoder()
            do{
                let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
                let name = decodedData.name
                let temp = decodedData.main.temp
                let id = (decodedData.weather[0].id)
                let lat = (decodedData.coord.lat)
                let lon = (decodedData.coord.lon)
                let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp, latitude: lat, longitude: lon)
                return weather
            } catch{
                delegate?.didFailWithError(error: error)
                return nil
            }
        }
    
    }
