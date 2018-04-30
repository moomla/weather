//
//  WeatherDataModelsTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherDataModelsTests: WeatherBaseTests {
    
    var city: City?
    var weather: WeatherData?
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        city = nil
        weather = nil
    }
    
    func test_cityInitialization() {
        let testName = "testName"
        let testId = "testId"
        city = City(city: testName, id: testId)
        XCTAssertEqual(city?.city, testName)
        XCTAssertEqual(city?.id, testId)
    }
    
    func test_weatherInitialization() {
        weather = instantiateLondonWeather()
        XCTAssertEqual(weather?.name, "London")
        XCTAssertEqual(weather?.id, 2643743)
    }
    
    func test_weatherMetricSystemChange() {
        let deegries: Float = 10
        weather = instantiateLondonWeather()
        weather?.metricSystem = .celsius
        weather?.temp = deegries
        weather?.metricSystem = .fahrenheit
        XCTAssertEqual(weather?.metricSystem, .fahrenheit)
        XCTAssertEqual(weather?.metricSystem.sign(), "F")
        XCTAssertEqual(weather?.temp, 50)
        
        weather?.metricSystem = .celsius
        XCTAssertEqual(weather?.metricSystem, .celsius)
        XCTAssertEqual(weather?.metricSystem.sign(), "C")
        XCTAssertEqual(weather?.temp, deegries)
    }
}
