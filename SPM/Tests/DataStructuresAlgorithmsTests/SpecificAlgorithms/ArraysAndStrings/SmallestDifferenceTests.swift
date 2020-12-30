//
//  SmallestDifferenceTests.swift
//  
//
//  Created by Stefan Jaindl on 17.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class SmallestDifferenceTests: XCTestCase {
    
    open func testSmallestDifference() {
        let smallestDifferenceFinder = SmallestDifference()
        
        XCTAssertEqual(smallestDifferenceFinder.smallestDifference(first: [], second: []), nil)
        XCTAssertEqual(smallestDifferenceFinder.smallestDifference(first: [1, 3, 15, 11, 2], second: [23, 127, 235, 19, 8]), 3)
    }
}
