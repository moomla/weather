//
//  WeatherData.swift
//  Weather
//
//  Created by dv51343 on 22/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

//{"coord":{"lon":-0.13,"lat":51.51},"weather":[{"id":801,"main":"Clouds","description":"few clouds","icon":"02d"}],"base":"stations","main":{"temp":21.63,"pressure":1008,"humidity":41,"temp_min":19,"temp_max":24},"visibility":10000,"wind":{"speed":7.2,"deg":240},"clouds":{"all":20},"dt":1524406800,"sys":{"type":1,"id":5091,"message":0.0671,"country":"GB","sunrise":1524372549,"sunset":1524424187},"id":2643743,"name":"London","cod":200}

struct WeatherDataServerResponce: Codable {
    struct Coordinate: Codable {
        let lon: Float
        let lat: Float
    }
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct MainWeatherData: Codable {
        let temp: Float
        let pressure: Float
        let humidity: Float
        let temp_min: Float
        let temp_max: Float
    }
    
    struct SysWeatherData: Codable {
        let type: Int
        let id: Int
        let message: Float
        let country: String
        let sunrise: Int
        let sunset: Int
    }
    
    struct WindData: Codable {
        let speed: Float
        let deg: Float?
    }
    
    let id: Int
    let name: String
    let coord: Coordinate
    let weather: [Weather]
    let base: String
    let main: MainWeatherData
    let visibility: Float
    let wind: WindData
    let dt: Int
    let clouds: [String: Int]
    let sys: SysWeatherData
    let cod: Int
    
}

 struct WeatherData {
    var id: Int = 0
    var name: String = ""
    var country: String = ""
    var weatherDescription: String = ""
    var icon: String = ""
    var code: Int = 0
    
    var temp: Float = 0
    var temp_min: Float = 0
    var temp_max: Float = 0
    var metricSystem: DegreesMetricSystem = .celsius {
        willSet(newMetricSystem) {
            if newMetricSystem != metricSystem {
                if (newMetricSystem == .fahrenheit){
                    temp = DegreesMetricSystem.celsius2Fahrenheit(temp)
                    temp_min = DegreesMetricSystem.celsius2Fahrenheit(temp_min)
                    temp_max = DegreesMetricSystem.celsius2Fahrenheit(temp_max)
                }else if (newMetricSystem == .celsius){
                    temp = DegreesMetricSystem.fahrenheit2Celsius(temp)
                    temp_min = DegreesMetricSystem.fahrenheit2Celsius(temp_min)
                    temp_max = DegreesMetricSystem.fahrenheit2Celsius(temp_max)
                }
            }
        }
    }
    
    init(){}
    
    init(response: WeatherDataServerResponce) {
        id = response.id
        name = response.name
        country = response.sys.country
        temp = response.main.temp
        temp_min = response.main.temp_min
        temp_max = response.main.temp_max
        let weather = response.weather[0]
        weatherDescription = weather.description
        icon = weather.icon
        code = weather.id
    }    
}
