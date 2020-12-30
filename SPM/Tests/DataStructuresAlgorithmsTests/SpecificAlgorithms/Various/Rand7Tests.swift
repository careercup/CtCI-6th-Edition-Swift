//
//  Rand7Tests.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class Rand7Tests: XCTestCase {
    
    open func testRand7() {
        let rand7 = Rand7()
        
        var array: [Int] = [Int](repeating: 0, count: 7)
        
        for _ in 0 ..< 10000 {
            let random = rand7.random()
            array[random] += 1
        }
        
        var average = 0
        array.forEach { entry in
            average += entry
        }
        
        average /= 7
        
        let lowerBound = Int(Double(average) * 0.75)
        let upperBound = Int(Double(average) * 1.25)
        
        array.forEach { entry in
            XCTAssertTrue(entry > lowerBound && entry < upperBound)
        }
    }
}
