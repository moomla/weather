//
//  WeatherProvidersTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherServiceTests: WeatherBaseTests {
    
    var dataService: WeatherService?
    var citiesProvider: CitiesDataProvider = DataProvidersFactory.citiesDataProvider()
    var weatherProvider: WeatherDataProvider = DataProvidersFactory.weatherDataProvider()
    
    override func setUp() {
        super.setUp()
        dataService = WeatherService.init(weatherProvider: weatherProvider, citiesDataProvider: citiesProvider)
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenUsingWeatherService_dataIsLoaded() {
        let london = loadLondonFromMockFile()
        var londonWeather: WeatherData? = nil
        let serviceExpectation = XCTestExpectation(description: "service data is loaded")
        
        dataService?.loadWeather(in: london, metricSystem: .celsius) { (weather, error) in
            londonWeather = weather
            serviceExpectation.fulfill()
        }

        wait(for: [serviceExpectation], timeout: 5.0)
        XCTAssertEqual(londonWeather?.name, london.city)
    }
    
}
