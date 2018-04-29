//
//  OpenWeatherMapDataProvider.swift
//  Weather
//
//  Created by dv51343 on 22/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

let APPID_TOKEN = "227742b225a78802d4ed5b27e9b3c6b9"
let CURRENT_WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather?units=metric&"
let WEATHER_ICON_URL = "http://openweathermap.org/img/w/"

class OpenWeatherMapDataProvider: WeatherDataProvider {
    
    func loadWeather(in city: City, metricSystem: DegreesMetricSystem, completion: @escaping (WeatherData?, Error?) -> ()) {
        guard let url = buildWeatherUrlWithParameters(in: city, metricSystem: metricSystem) else {
            notifyOnError(completion as! (Any?, Error?) -> (), error: nil)
            return
        }
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: url) {(responseData, response, error) -> Void in
            guard let data = responseData, error == nil else {
               self.notifyOnError(completion, error: error)
               return
            }
            
            if let weather = self.parseWeatherJson(jsonData: data) {
                OperationQueue.main.addOperation({
                    completion(weather, nil)
                })
            }else{
                self.notifyOnError(completion, error: error)
            }
        }.resume()
    }
    
    func loadIcon(_ iconCode: String, completion: @escaping (UIImage?, Error?) -> ()) {
        let urlStr = WEATHER_ICON_URL + iconCode + ".png"
        
        guard let url = URL(string: urlStr) else {
            completion(nil, error)
            return
        }
        
        //fetching the data from the url
        URLSession.shared.dataTask(with: url) {(responseData, response, error) -> Void in
            guard let data = responseData, error == nil else {
                OperationQueue.main.addOperation({
                    completion(nil, error)
                })
                return
            }
            
            let image = UIImage(data: data)
            OperationQueue.main.addOperation({
                completion(image, error)
            })
        }.resume()
    }
    
    
    private func notifyOnError(_ completion: @escaping (WeatherData?, Error?) -> (), error: Error?) {
        OperationQueue.main.addOperation({
            completion(nil, error)
        })
    }
    
    private func buildWeatherUrlWithParameters(in city: City, metricSystem: DegreesMetricSystem) -> URL? {
        var parameters = [String: String]()
        parameters["id"] = city.id.description
        parameters["APPID"] = APPID_TOKEN
        
        if metricSystem == .celsius {
            parameters["units"] = "metric"
        }else if metricSystem == .fahrenheit {
            parameters["units"] = "imperial"
        }
        
        var urlStr = CURRENT_WEATHER_URL
        for (key, value) in parameters {
            urlStr = urlStr + "&" + key + "=" + value
        }
        
        return URL(string: urlStr)
    }
    
    private func parseWeatherJson(jsonData: Data) -> WeatherData? {
        let decoder = JSONDecoder()
        do {
            let weatherResponce = try decoder.decode(WeatherDataServerResponce.self, from: jsonData)
            return WeatherData(response: weatherResponce)
        } catch {
            print("error trying to convert data to JSON " + error)
            return nil
        }
    }
    
}

