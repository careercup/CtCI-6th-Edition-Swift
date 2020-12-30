//
//  BinaryNearbySearcherTests.swift
//  
//
//  Created by Stefan Jaindl on 29.07.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class BinaryNearbySearcherTests: XCTestCase {
    
    open func testNearestBinaryNumbers() {
        let searcher = BinaryNearbySearcher()
        
        var result = searcher.nearestBinaryNumbers(number: 0b1011)
        XCTAssertEqual(result.0, 0b1101)
        XCTAssertEqual(result.1, 0b0111)
        
        result = searcher.nearestBinaryNumbers(number: 0b0111)
        XCTAssertEqual(result.0, 0b1011)
        XCTAssertEqual(result.1, nil)
        
        result = searcher.nearestBinaryNumbers(number: 0b11011)
        XCTAssertEqual(result.0, 0b11101)
        XCTAssertEqual(result.1, 0b10111)
        
        result = searcher.nearestBinaryNumbers(number: 0b1100)
        XCTAssertEqual(result.0, 0b10001)
        XCTAssertEqual(result.1, 0b1010)
    }
}
