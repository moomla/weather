//
//  CitiesDataProvider.swift
//  Weather
//
//  Created by dv51343 on 26/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation


class CitiesFileDataProvider: CitiesDataProvider {
    func citiesList() -> [City]? {
        let bundle = Bundle(for: type(of: self))
        let pathUrl = bundle.url(forResource: "cities", withExtension: "txt")
        return citiesListFromFileAtPath(pathUrl)
    }
    
    func citiesListFromFileAtPath(_ urlPath: URL?) -> [City]? {
        if let citiesList = JsonReader<CitiesList>.objectFromFileAtPath(urlPath) {
            return citiesList.cities
        }
        return nil
    }
}
