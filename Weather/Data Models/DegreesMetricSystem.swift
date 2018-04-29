//
//  DegreesMetricSystem.swift
//  Weather
//
//  Created by dv51343 on 26/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

enum DegreesMetricSystem: String, Codable {
    case celsius = "celsius"
    case fahrenheit = "fahrenheit"
    
    func sign() -> String {
        switch self {
        case .celsius:
            return "C"
        case .fahrenheit:
            return "F"
        }
    }
    
    static func celsius2Fahrenheit(_ degrees: Float) -> Float{
        return (degrees - 32) / 1.8
    }
    
    static func fahrenheit2Celsius(_ degrees: Float) -> Float{
        return (degrees * 1.8) + 32
    }
}
