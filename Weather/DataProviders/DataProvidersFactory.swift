//
//  DataProvidersFactory.swift
//  Weather
//
//  Created by dv51343 on 26/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

protocol WeatherDataProvider {
    func loadWeather(in city: City, metricSystem: DegreesMetricSystem, completion: @escaping (WeatherData?, Error?) -> ())
    func loadIcon(_ iconCode: String, completion: @escaping (UIImage?, Error?) -> ())
}

protocol CitiesDataProvider {
    func citiesList() -> [City]?
}


class DataProvidersFactory {
    static func weatherDataProvider() -> WeatherDataProvider {
        //no logic here
        return OpenWeatherMapDataProvider()
    }
    
    static func citiesDataProvider() -> CitiesDataProvider {
        //no logic here
        return CitiesFileDataProvider()
    }
    
}
