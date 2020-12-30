//
//  CountOfTwosTests.swift
//  
//
//  Created by Stefan Jaindl on 05.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class CountOfTwosTests: XCTestCase {
    
    open func testTwosCount() {
        let counter = CountOfTwos()
        
        XCTAssertEqual(counter.countOfTwos(number: 0), 0)
        XCTAssertEqual(counter.countOfTwos(number: 1), 0)
        XCTAssertEqual(counter.countOfTwos(number: 2), 1)
        XCTAssertEqual(counter.countOfTwos(number: 3), 1)
        XCTAssertEqual(counter.countOfTwos(number: 10), 1)
        XCTAssertEqual(counter.countOfTwos(number: 11), 1)
        XCTAssertEqual(counter.countOfTwos(number: 12), 2)
        XCTAssertEqual(counter.countOfTwos(number: 19), 2)
        XCTAssertEqual(counter.countOfTwos(number: 20), 3)
        XCTAssertEqual(counter.countOfTwos(number: 22), 6)
        XCTAssertEqual(counter.countOfTwos(number: 25), 9)
        XCTAssertEqual(counter.countOfTwos(number: 30), 13)
        XCTAssertEqual(counter.countOfTwos(number: 99), 20)
        XCTAssertEqual(counter.countOfTwos(number: 100), 20)
        XCTAssertEqual(counter.countOfTwos(number: 122), 26)
        XCTAssertEqual(counter.countOfTwos(number: 130), 33)
        XCTAssertEqual(counter.countOfTwos(number: 199), 40)
        XCTAssertEqual(counter.countOfTwos(number: 200), 41)
        XCTAssertEqual(counter.countOfTwos(number: 250), 106)
        XCTAssertEqual(counter.countOfTwos(number: 300), 160)
        XCTAssertEqual(counter.countOfTwos(number: 400), 180)
        XCTAssertEqual(counter.countOfTwos(number: 900), 280)
        XCTAssertEqual(counter.countOfTwos(number: 999), 300)
        XCTAssertEqual(counter.countOfTwos(number: 1000), 300)
        XCTAssertEqual(counter.countOfTwos(number: 2000), 601)
        XCTAssertEqual(counter.countOfTwos(number: 3000), 1900)
        XCTAssertEqual(counter.countOfTwos(number: 5000), 2500)
        XCTAssertEqual(counter.countOfTwos(number: 9000), 3700)
        XCTAssertEqual(counter.countOfTwos(number: 10000), 4000)
        XCTAssertEqual(counter.countOfTwos(number: 20000), 8001)
        XCTAssertEqual(counter.countOfTwos(number: 30000), 22000)
        XCTAssertEqual(counter.countOfTwos(number: 100000), 50000)
        XCTAssertEqual(counter.countOfTwos(number: 100002), 50001)
    }
}
