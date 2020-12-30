//
//  OperationsTests.swift
//  
//
//  Created by Stefan Jaindl on 21.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class OperationsTests: XCTestCase {
    
    open func testOperations() {
        let operations = Operations()
        
        XCTAssertEqual(operations.add(first: 4, second: 5), 9)
        
        XCTAssertEqual(operations.multiply(first: 4, second: 5), 20)
        XCTAssertEqual(operations.multiply(first: -2, second: 50), -100)
        XCTAssertEqual(operations.multiply(first: -4, second: -10), 40)
        
        XCTAssertEqual(operations.subtract(first: 5, second: 10), -5)
        XCTAssertEqual(operations.subtract(first: 10, second: 5), 5)
        XCTAssertEqual(operations.divide(first: 10, second: 5), 2)
        XCTAssertEqual(operations.divide(first: 10, second: 4), 2)
        XCTAssertEqual(operations.divide(first: 100, second: -5), -20)
        XCTAssertEqual(operations.divide(first: -100, second: -5), 20)
    }
}

