//
//  AppStates.swift
//  WeatherUITests
//
//  Created by dv51343 on 30/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
import XCTest


public extension XCUIApplication {
    
    public var weatherDetailsScreenElement: XCUIElement {
        return otherElements["weatherDetailsScreen"]
    }
    
    public var citiesScreenElement: XCUIElement {
        return otherElements["citiesListScreen"]
    }
    
    public var isDisplayingCitiesList: Bool {
        return citiesScreenElement.waitForExistence(timeout: 5)
    }
    
    public var isDisplayingWeatherDetails: Bool {
        return weatherDetailsScreenElement.waitForExistence(timeout: 5)
    }
    
    public var noDataScreenView: XCUIElement {
        return weatherDetailsScreenElement.otherElements["noDataView"]
    }
    
    public var isDisplayingNoDataScreen: Bool {
        return noDataScreenView.exists
    }
}
