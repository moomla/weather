//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherBaseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func loadLondonFromMockFile() -> City {
        let testBundle = Bundle(for: type(of: self))
        let pathUrl = testBundle.url(forResource: "london_mock", withExtension: "txt")
        let cities = CitiesFileDataProvider().citiesListFromFileAtPath(pathUrl)
        XCTAssertEqual(cities?.count, 1)
        return cities![0]
    }
    
    func instantiateLondonWeather() -> WeatherData {
        let testBundle = Bundle(for: type(of: self))
        let pathUrl = testBundle.url(forResource: "londonWeather", withExtension: "txt")
        guard let responce = JsonParser<WeatherDataServerResponce>.objectFromFileAtPath(pathUrl) else {
            XCTFail("error reading weather responce")
            return WeatherData()
        }
        return WeatherData(response: responce)
    }
    
}
