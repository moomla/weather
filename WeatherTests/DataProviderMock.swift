//
//  DataProviderMock.swift
//  WeatherTests
//
//  Created by dv51343 on 29/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
@testable import Weather

class OpenWeatherMapDataProviderMock : WeatherDataProvider {
    
    var loadWeatherClosure:((WeatherData?, Error?) -> ()) = {(weather, error) in
        
    }
    
    func loadWeather(in city: City, metricSystem: DegreesMetricSystem, completion: @escaping (WeatherData?, Error?) -> ()) {
        return loadWeatherClosure(nil, nil)
    }
    
    var loadIconClosure:((UIImage?, Error?) -> ()) = {(image, error) in
        
    }
    
    func loadIcon(_ iconCode: String, completion: @escaping (UIImage?, Error?) -> ()) {
         return loadIconClosure(nil, nil)
    }
}
