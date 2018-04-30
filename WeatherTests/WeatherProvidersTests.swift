//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherProvidersTests: XCTestCase {
    
    var dataProvider: WeatherService? = WeatherService()
    var citiesDataProvider: CitiesFileDataProvider = CitiesFileDataProvider()
    
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
    
    func testWhenUsingMockList_2CitiesAreReturned() {
        let testBundle = Bundle(for: type(of: self))
        let pathUrl = testBundle.url(forResource: "cities_mock", withExtension: "txt")
        let cities = citiesDataProvider.citiesListFromFileAtPath(pathUrl)
        XCTAssertEqual(cities?.count, 2)
    }
    
//    func testWhenUsingMockList_2CitiesAreReturned() {
//        let testBundle = Bundle(for: type(of: self))
//        let pathUrl = testBundle.url(forResource: "cities_mock", withExtension: "txt")
//        let cities = citiesDataProvider.citiesListFromFileAtPath(pathUrl)
//        XCTAssertEqual(cities?.count, 2)
//    }
    
}
