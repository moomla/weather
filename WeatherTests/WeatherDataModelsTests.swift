//
//  WeatherDataModelsTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherDataModelsTests: XCTestCase {
    
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
        let testBundle = Bundle(for: type(of: self))
        let pathUrl = testBundle.url(forResource: "londonWeather", withExtension: "txt")
        guard let responce = JsonReader<WeatherDataServerResponce>.objectFromFileAtPath(pathUrl) else {
            XCTFail("error reading weather responce")
            return
        }
        weather = WeatherData(response: responce)
        XCTAssertEqual(weather?.name, "London")
        XCTAssertEqual(weather?.id, 2643743)
    }
    
}
