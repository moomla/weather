//
//  WeatherTests.swift
//  WeatherTests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest
@testable import Weather

class WeatherTests: XCTestCase {
    
    var dataProvider: WeatherService? = WeatherService()
    var citiesDataProvider: CitiesFileDataProvider = CitiesFileDataProvider()
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testWhenEmptyList_noCitiesAreReturned() {
        let cities = citiesDataProvider.citiesListFromFileNamed("cities_empty")
        XCTAssertNil(cities)
    }
    
    func testWhenUsingMockList_2CitiesAreReturned() {
        let cities = citiesDataProvider.citiesListFromFileNamed("cities_mock")
        XCTAssertEqual(cities?.count, 2)
    }
    
}
