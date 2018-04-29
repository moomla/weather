//
//  CitiesProviderMock.swift
//  WeatherTests
//
//  Created by dv51343 on 29/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit
@testable import Weather

class CitiesProviderMock: CitiesDataProvider {
    var loadCitiesClosure: (() -> [City]?)?
    
    func citiesList() -> [City]? {
        return loadCitiesClosure?()
    }
}
