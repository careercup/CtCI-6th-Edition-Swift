//
//  CircularArrayTests.swift
//  
//
//  Created by Stefan Jaindl on 10.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class CircularArrayTests: XCTestCase {
    open func testCircularArray() {
        let array = [1, 2, 3, 4, 5]
        let circularArray = CircularArray<Int>(array: array)
        
        var iterator = circularArray.makeIterator()
        XCTAssertEqual(iterator.next(), 1)
        
        circularArray.leftRotate(by: 2)
        iterator = circularArray.makeIterator()
        XCTAssertEqual(iterator.next(), 3)
        XCTAssertEqual(iterator.next(), 4)
        XCTAssertEqual(iterator.next(), 5)
        XCTAssertEqual(iterator.next(), 1)
        XCTAssertEqual(iterator.next(), 2)
        XCTAssertEqual(iterator.next(), nil)
        
        circularArray.rightRotate(by: 4)
        iterator = circularArray.makeIterator()
        XCTAssertEqual(iterator.next(), 4)
        XCTAssertEqual(iterator.next(), 5)
        XCTAssertEqual(iterator.next(), 1)
        XCTAssertEqual(iterator.next(), 2)
        XCTAssertEqual(iterator.next(), 3)
        XCTAssertEqual(iterator.next(), nil)
    }
}
