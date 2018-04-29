//
//  Utils.swift
//  Weather
//
//  Created by dv51343 on 26/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import UIKit

class Utils {
    
    static func degreeFormated(_ degree: Float, metricSystem: DegreesMetricSystem) -> String {
        return String(round(degree)) + "°" + metricSystem.sign()
    }
    
    static func colorByCode(_ code: Int) -> UIColor {
        switch code {
        case 200...300: //thunderstorm  #0059b3
            return UIColor(red: 0, green: 0x59, blue: 0xB3 )
        case 300...400: //drizzle  #e6f9ff
            return UIColor(red: 0xE6, green: 0xF9, blue: 0xFF)
        case 500...600: //rain #9fbfdf
            return UIColor(red: 0x9F, green: 0xBF, blue: 0xDF)
        case 601...700: //snow  #66ffff
            return UIColor(red: 0x66, green: 0xFF, blue: 0xFF)
        case 701...799: //athmosphere #d6f5f5
            return UIColor(red: 0xD6, green: 0xF5, blue: 0xF5)
        case 800: //clear
            return UIColor(red: 0xFF, green: 0xFF, blue: 0xE6)
        case 801...809: //clouds  #d1e0e0
            return UIColor(red: 0xD1, green: 0xE0, blue: 0xE0)
        case 900...909: //extreme #ff471a
            return UIColor(red: 0xFF, green: 0x47, blue: 0x1A)
        default:
            return UIColor.clear
        }
    }
}
