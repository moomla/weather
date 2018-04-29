//
//  City.swift
//  Weather
//
//  Created by dv51343 on 22/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

struct CitiesList: Codable {
    let cities: [City]
}

struct City: Codable {
    let city: String
    let id: String
}
