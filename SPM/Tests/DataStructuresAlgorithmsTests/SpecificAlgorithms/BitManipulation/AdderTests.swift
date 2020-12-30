//
//  AdderTests.swift
//  
//
//  Created by Stefan Jaindl on 03.12.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class AdderTests: XCTestCase {
    
    open func testAddWithoutPlus() {
        let adder = Adder()
        XCTAssertEqual(adder.addWithoutPlus(first: 0, second: 0), 0)
        XCTAssertEqual(adder.addWithoutPlus(first: 0, second: 1), 1)
        XCTAssertEqual(adder.addWithoutPlus(first: 1, second: 0), 1)
        XCTAssertEqual(adder.addWithoutPlus(first: 1, second: 2), 3)
        XCTAssertEqual(adder.addWithoutPlus(first: 2, second: 2), 4)
        XCTAssertEqual(adder.addWithoutPlus(first: 3, second: 3), 6)
        XCTAssertEqual(adder.addWithoutPlus(first: 4, second: 7), 11)
        XCTAssertEqual(adder.addWithoutPlus(first: 25, second: 13), 38)
    }
}
