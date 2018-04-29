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
        return citiesListFromFileNamed("cities")
    }
    
    func citiesListFromFileNamed(_ file: String) -> [City]? {
        if let path = Bundle.main.path(forResource: file , ofType: "txt") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let citiesList = try decoder.decode(CitiesList.self, from: data)
                return citiesList.cities
            } catch {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        
        return nil
    }
}
