//
//  RandomUtils.swift
//  GetirBootcampFinalProject
//
//  Created by Selman Adanir on 25.04.2024.
//

import Foundation

final class RandomUtils {
    
    class func generateRandomInt(inClosedRange range: ClosedRange<Int>) -> Int {
        return Int.random(in: range)
    }

    class func generateRandomInt(inRange range: Range<Int>) -> Int {
        return Int.random(in: range)
    }

    
    class func generateRandomDouble(inClosedRange range: ClosedRange<Double>) -> Double {
        return Double.random(in: range)
    }
}
