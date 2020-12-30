//
//  DuplicateFinderTests.swift
//  
//
//  Created by Stefan Jaindl on 25.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class DuplicateFinderTests: XCTestCase {
    
    open func testFindDuplicates() {
        let array = [1, 1, 3, 5, 7, 10, 3, 32000, 0, 3000, 32000]
        let finder = DuplicateFinder()
        let duplicates = finder.findDuplicates(array: array, maxValue: 32000)
        
        XCTAssertTrue(duplicates.contains(1))
        XCTAssertTrue(duplicates.contains(3))
        XCTAssertTrue(duplicates.contains(32000))
        XCTAssertEqual(duplicates.count, 3)
    }
}
