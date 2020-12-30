//
//  WordFrequencyCounterTests.swift
//  
//
//  Created by Stefan Jaindl on 15.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class WordFrequencyCounterTests: XCTestCase {
    
    open func testCounts() {
        let counter = WordFrequencyCounter(words: ["test", "   test    ", "xxx", "Test ", "unique", "special", "special"])
        
        XCTAssertEqual(counter.count(of: "test"), 3)
        XCTAssertEqual(counter.count(of: "xxx"), 1)
        XCTAssertEqual(counter.count(of: "test_"), 0)
        XCTAssertEqual(counter.count(of: "special"), 2)
        XCTAssertEqual(counter.count(of: "unique"), 1)
    }
}
