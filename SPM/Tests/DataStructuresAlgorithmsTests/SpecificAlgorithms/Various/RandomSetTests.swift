//
//  RandomSetTests.swift
//  
//
//  Created by Stefan Jaindl on 04.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class RandomSetTests: XCTestCase {
    
    open func testRandomSet() {
        let randomizer = RandomSet<Int>()
        
        var randomSet = Set<Int>()
        
        for _ in 0 ..< 20 {
            let random = randomizer.randomSet(of: 5, from: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
            randomSet.insert(random[0])
        }
        
        XCTAssertTrue(randomSet.count >= 8) //statistical assumption
    }
}
