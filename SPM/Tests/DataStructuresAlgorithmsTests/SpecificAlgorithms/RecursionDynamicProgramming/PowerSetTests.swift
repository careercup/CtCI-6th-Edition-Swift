//
//  PowerSetTests.swift
//  
//
//  Created by Stefan Jaindl on 15.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PowerSetTests: XCTestCase {
    
    open func testPowerSetPermutations() {
        let powerSet = PowerSet<Int>()
        let sets = powerSet.powerSetPermutations(set: [1, 2, 3])
        
        XCTAssertEqual(sets, [[], [1], [2], [3], [1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2], [1, 2, 3], [1, 3, 2], [2, 1, 3], [2, 3, 1], [3, 1, 2], [3, 2, 1]])
    }
    
    open func testPowerSetCombinations() {
        let powerSet = PowerSet<Int>()
        let sets = powerSet.powerSetCombinations(set: [1, 2, 3])
        
        XCTAssertEqual(sets, [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
    }
    
    open func testPowerSetCombinationsByBitmasking() {
        let powerSet = PowerSet<Int>()
        let sets = powerSet.powerSetCombinationsByBitMasking(set: [1, 2, 3])
        
        XCTAssertEqual(sets, [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]])
    }
}
