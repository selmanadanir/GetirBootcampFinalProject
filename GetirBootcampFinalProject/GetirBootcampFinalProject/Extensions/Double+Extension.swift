//
//  Double+Extension.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 19.04.2024.
//

import Foundation

extension Double {
    func round(to places: Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Double {
    func count() -> Int {
        if self == Double(Int(self)) {
            return 0
        }

        let doubleString = String(Double(self))
        return doubleString.count - 1
    }
}
