//
//  WeatherService.swift
//  Weather
//
//  Created by dv51343 on 26/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class WeatherService {
    
    var weatherProvider: WeatherDataProvider
    var citiesProvider: CitiesDataProvider
    
    init(weatherProvider: WeatherDataProvider, citiesDataProvider: CitiesDataProvider) {
        self.weatherProvider = weatherProvider
        self.citiesProvider = citiesDataProvider
    }
    
    func loadWeather(in city: City, metricSystem: DegreesMetricSystem, completion: @escaping (WeatherData?, Error?) -> ()) {
        weatherProvider.loadWeather(in: city, metricSystem: metricSystem, completion: completion)
    }
    
    func loadIcon(_ iconCode: String, completion: @escaping (UIImage?, Error?) -> ()) {
        weatherProvider.loadIcon(iconCode, completion: completion)
    }
    
    func citiesList() -> [City]? {
        return citiesProvider.citiesList()
    }
    
}
