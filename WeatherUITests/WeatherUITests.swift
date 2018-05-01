//
//  WeatherUITests.swift
//  WeatherUITests
//
//  Created by dv51343 on 17/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import XCTest

class WeatherUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        app = XCUIApplication()
        app.launchArguments.append("--uitesting")
        app.launch()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func loadAndTapOnLondonCell() {
        assertCitiesDisplay()
        
        //find cell
        let tableView = app.tables["citiesTable"]
        let cell = tableView.cells.containing(.cell, identifier: "0")
        let cellLabelText = cell.staticTexts.element(boundBy: 0).label
        XCTAssertEqual(cellLabelText, "London")
        
        //tap the cell
        cell.staticTexts.element(boundBy: 0).tap()
        
        //assert we are in the weather screen
        XCTAssertTrue(app.isDisplayingWeatherDetails)
    }
    
    func testStart() {
        loadAndTapOnLondonCell()
        
        checkWeatherDataView()
//        checkNoDataView()
        
        backToCitiesScreen()
    }
    
    func checkWeatherDataView() {
        //no data is not presented
        XCTAssertFalse(app.isDisplayingNoDataScreen)
        
        //assert the label are being populated
        let title = app.weatherDetailsScreenElement.staticTexts["cityNameLabel"]
        XCTAssertNotNil(title.exists)
        XCTAssertEqual(title.label, "London")
        XCTAssertNotNil(app.images["iconView"].exists)
        XCTAssertNotEqual(app.staticTexts["cityNameLabel"].label, "Label")
        XCTAssertNotEqual(app.staticTexts["descriptionLabel"].label, "Label")
        XCTAssertNotEqual(app.staticTexts["currentTempLabel"].label, "Label")
        XCTAssertNotEqual(app.staticTexts["tempRangeLabel"].label, "Label")
        
        //check metric system buttons taps change the state
        app.weatherDetailsScreenElement.buttons["celsiusButton"].tap()
        let currentTempText = app.weatherDetailsScreenElement.staticTexts["currentTempLabel"].label
        app.weatherDetailsScreenElement.buttons["fahrenheitButton"].tap()
        var currentTempLabelChanged = app.weatherDetailsScreenElement.staticTexts["currentTempLabel"].label
        XCTAssertNotEqual(currentTempText, currentTempLabelChanged)
        app.weatherDetailsScreenElement.buttons["celsiusButton"].tap()
        currentTempLabelChanged = app.weatherDetailsScreenElement.staticTexts["currentTempLabel"].label
        XCTAssertEqual(currentTempText, currentTempLabelChanged)
        
    }
    
    func backToCitiesScreen(){
        app.navigationBars.buttons.element(boundBy: 0).tap()
        assertCitiesDisplay()
    }
    
    func assertCitiesDisplay() {
        //assert we are in the cities screen
        XCTAssertTrue(app.isDisplayingCitiesList)
        
        //find table
        let tableView = app.tables["citiesTable"]
        XCTAssert(tableView.cells.count == 25)
    }
    
    
    func checkNoDataView() {
        XCTAssertTrue(app.isDisplayingNoDataScreen)
        let errorLabelShown = app.noDataScreenView.staticTexts["errorLabel"].exists
        let loadingIsShown = app.noDataScreenView.activityIndicators["activityIndicator"].exists
        XCTAssertTrue(errorLabelShown || loadingIsShown)
    }
}
