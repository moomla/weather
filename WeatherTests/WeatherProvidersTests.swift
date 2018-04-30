//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherProvidersTests: WeatherBaseTests {
    
    var citiesDataProvider = CitiesFileDataProvider()
    var weatherDataProvider = OpenWeatherMapDataProvider()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenEmptyList_noCitiesAreReturned() {
        let testBundle = Bundle(for: type(of: self))
        let pathUrl = testBundle.url(forResource: "cities_empty", withExtension: "txt")
        let cities = citiesDataProvider.citiesListFromFileAtPath(pathUrl)
        XCTAssertNil(cities)
    }
    
    func testWhenUsingMockList_LondonIsReturned() {
        let london = loadLondonFromMockFile()
        XCTAssertEqual(london.city, "London")
    }
    
    func test_iconLoading() {
        let weather = instantiateLondonWeather()
        weatherDataProvider.loadIcon(weather.icon) { (image, error) in
            XCTAssertNotNil(image)
        }
    }
    
    func test_weatherDataLoading() {
        let london = loadLondonFromMockFile()
        var londonWeather: WeatherData? = nil
        let serviceExpectation = XCTestExpectation(description: "service data is loaded")
        
        weatherDataProvider.loadWeather(in: london, metricSystem: .celsius) { (weather, error) in
            londonWeather = weather
            serviceExpectation.fulfill()
        }
        
        wait(for: [serviceExpectation], timeout: 5.0)
        XCTAssertEqual(londonWeather?.name, london.city)
    }
    
    func testWhenCityIdIsWrong_thenNothingIsLoaded() {
        let nonExistantCity = City(city: "Test", id: "10010012898999")
        let serviceExpectation = XCTestExpectation(description: "service data is loaded")

        weatherDataProvider.loadWeather(in: nonExistantCity, metricSystem: .celsius) { (weather, error) in
            serviceExpectation.fulfill()
            XCTAssertNil(weather)
        }
        
        wait(for: [serviceExpectation], timeout: 10.0)
    }
    
//    func testWhenCity_thenUrlWillBeInvalid() {
//        let nonExistantCity = City(city: "Test", id: "10010012898999")
//        let serviceExpectation = XCTestExpectation(description: "service data is loaded")
//        
//        weatherDataProvider.loadWeather(in: nonExistantCity, metricSystem: .celsius) { (weather, error) in
//            serviceExpectation.fulfill()
//            XCTAssertNil(weather)
//        }
//        
//        wait(for: [serviceExpectation], timeout: 10.0)
//    }
    
    
}
