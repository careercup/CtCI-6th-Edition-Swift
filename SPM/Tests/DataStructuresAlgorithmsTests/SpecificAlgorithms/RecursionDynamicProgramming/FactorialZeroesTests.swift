//
//  FactorialZeroesTests.swift
//  
//
//  Created by Stefan Jaindl on 16.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class FactorialZeroesTests: XCTestCase {
    
    open func testTrailingZeroCount() {
        let counter = FactorialZeroes()
        
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 1), 0)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 5), 1)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 10), 2)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 15), 3)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 20), 4)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 25), 6)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 30), 7)
        XCTAssertEqual(counter.factorialTrailingZeroesCount(number: 32), 7)
    }
}
