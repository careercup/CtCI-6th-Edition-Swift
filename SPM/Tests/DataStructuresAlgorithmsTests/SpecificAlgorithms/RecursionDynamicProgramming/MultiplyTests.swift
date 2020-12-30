//
//  MultiplyTests.swift
//  
//
//  Created by Stefan Jaindl on 16.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MultiplyTests: XCTestCase {
    
    open func testMultiply() {
        let multiplier = Multiplyer()
        
        XCTAssertEqual(multiplier.multiply(3, with: 4), 12)
        XCTAssertEqual(multiplier.multiply(4, with: 3), 12)
        XCTAssertEqual(multiplier.multiply(0, with: 3), 0)
        XCTAssertEqual(multiplier.multiply(4, with: 0), 0)
        XCTAssertEqual(multiplier.multiply(4, with: 1), 4)
        XCTAssertEqual(multiplier.multiply(1, with: 3), 3)
        XCTAssertEqual(multiplier.multiply(8, with: 2), 16)
        XCTAssertEqual(multiplier.multiply(12, with: 9), 108)
        XCTAssertEqual(multiplier.multiply(7, with: 7), 49)
    }
}
