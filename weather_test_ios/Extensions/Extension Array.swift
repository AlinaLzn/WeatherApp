//
//  Extension Array.swift
//  weather_test_ios
//
//  Created by Alina on 2020-08-27.
//  Copyright © 2020 Alina. All rights reserved.
//

import Foundation

public extension Array {
    subscript (safe index: Int) -> Element? {
        guard indices.contains(index), index >= 0, index < count else { return nil }
        return self[index]
    }
}
