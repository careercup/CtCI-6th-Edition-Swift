//
//  MissingTwoTests.swift
//  
//
//  Created by Stefan Jaindl on 13.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MissingTwoTests: XCTestCase {
    
    open func testMissing() {
        let misser = MissingTwo()
        
        XCTAssertEqual(misser.findMissingNumber(in: [1, 5, 2, 3]), 4)
        XCTAssertEqual(misser.findMissingTwoNumbers(in: [1, 5, 3]), [2, 4])
        XCTAssertEqual(misser.findMissingTwoNumbers(in: [1, 5, 3, 7, 8, 9, 2]), [4, 6])
        XCTAssertEqual(misser.findMissingNumber(in: [2]), 1)
        XCTAssertEqual(misser.findMissingNumber(in: []), nil)
        XCTAssertEqual(misser.findMissingTwoNumbers(in: []), [])
        
        XCTAssertEqual(misser.findMissingTwoNumbersWithLessSpace(in: [1, 5, 3]), [2, 4])
        XCTAssertEqual(misser.findMissingTwoNumbersWithLessSpace(in: [1, 5, 3, 7, 8, 9, 2]), [4, 6])
        XCTAssertEqual(misser.findMissingTwoNumbersWithLessSpace(in: []), [])
    }
}
