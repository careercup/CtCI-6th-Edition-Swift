//
//  MajorityElementTests.swift
//  
//
//  Created by Stefan Jaindl on 08.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MajorityElementTests: XCTestCase {
    open func testMajorityElement() {
        let array = [1, 2, 5, 9, 5, 9, 5, 5, 5]
        let majorityFinder = MajorityElement()
        
        XCTAssertEqual(majorityFinder.find(array: array), 5)
        XCTAssertEqual(majorityFinder.find(array: [1, 2, 5, 9, 5, 9, 5, 5]), nil)
        XCTAssertEqual(majorityFinder.find(array: [1, 2, 1]), 1)
        XCTAssertEqual(majorityFinder.find(array: [1]), 1)
        XCTAssertEqual(majorityFinder.find(array: [1, 1]), 1)
        XCTAssertEqual(majorityFinder.find(array: [1, 2]), nil)
        XCTAssertEqual(majorityFinder.find(array: [1, 2, 3]), nil)
        XCTAssertEqual(majorityFinder.find(array: []), nil)
    }
}
