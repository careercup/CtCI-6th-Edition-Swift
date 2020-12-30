//
//  NumberMaxTests.swift
//  
//
//  Created by Stefan Jaindl on 18.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class NumberMaxTests: XCTestCase {
    
    open func testMaxNumber() {
        let maxNumberTester = NumberMax()
        
        XCTAssertEqual(maxNumberTester.max(first: 8, second: 12), 12)
        XCTAssertEqual(maxNumberTester.max(first: 8, second: 0), 8)
        XCTAssertEqual(maxNumberTester.max(first: 8, second: 8), 8)
        XCTAssertEqual(maxNumberTester.max(first: -10, second: -8), -8)
        XCTAssertEqual(maxNumberTester.max(first: 0, second: 0), 0)
        XCTAssertEqual(maxNumberTester.max(first: Int.max, second: 12), Int.max)
    }
}
