//
//  JsonReader.swift
//  Weather
//
//  Created by dv51343 on 30/04/2018.
//  Copyright © 2018 test. All rights reserved.
//

import Foundation

class JsonReader<T:Codable> {
    static func objectFromFileAtPath(_ urlPath: URL?) -> T? {
        if let path = urlPath {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                let object = try decoder.decode(T.self, from: data)
                return object
            } catch {
                print("parse error: \(error.localizedDescription)")
            }
        } else {
            print("Invalid filename/path.")
        }
        return nil
    }
}
