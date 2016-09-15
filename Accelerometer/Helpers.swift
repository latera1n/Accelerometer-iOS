//
//  Helpers.swift
//  Accelerometer
//
//  Created by DengYuchi on 9/14/16.
//  Copyright © 2016 LateRain. All rights reserved.
//

import Foundation

class Helpers {
    static func calculateOverallAcceleration(x: Double, y: Double, z: Double) -> Double {
        return sqrt(x * x + y * y + z * z)
    }
}

extension NumberFormatter {
    func stringWithoutNegativeZeros(from: Double) -> String? {
        return (from < 0.0 && from > -0.005) ? "0.00" : self.string(from: from as NSNumber)
    }
}

extension Double {
    var twoDecimalDigitsRounded: Double {
        return Double(Int((self + 0.005) * 100.0)) / 100.0
    }
}
