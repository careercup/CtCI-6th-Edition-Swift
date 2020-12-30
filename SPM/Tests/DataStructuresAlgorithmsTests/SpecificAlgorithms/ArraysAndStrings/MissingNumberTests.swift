//
//  MissingNumberTests.swift
//  
//
//  Created by Stefan Jaindl on 04.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MissingNumberTests: XCTestCase {
    
    open func testMissingNumber() {
        let missingNumber = MissingNumber()
        
        XCTAssertEqual(missingNumber.findMissingNumber(of: [0, 1, 2, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13], lenght: 13), 3)
        XCTAssertEqual(missingNumber.findMissingNumber(of: [1, 2, 3], lenght: 3), 0)
        XCTAssertEqual(missingNumber.findMissingNumber(of: [1, 2, 3], lenght: 3), 0)
        XCTAssertEqual(missingNumber.findMissingNumber(of: [0, 1, 4, 3, 5, 6, 7, 8, 9, 10], lenght: 10), 2)
        XCTAssertEqual(missingNumber.findMissingNumber(of: [0, 1, 4, 3, 5, 6, 7, 8, 9], lenght: 9), 2)
        XCTAssertEqual(missingNumber.findMissingNumber(of: [0, 1, 4, 3, 5, 6, 7, 8, 2], lenght: 9), 9)
        XCTAssertEqual(missingNumber.findMissingNumber(of: [0, 1, 4, 3, 5, 6, 7, 8], lenght: 9), nil)
    }
}
