//
//  WordDistanceTests.swift
//  
//
//  Created by Stefan Jaindl on 09.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class WordDistanceTests: XCTestCase {
    
    open func testMinDistance() {
        let words = [
            "test",
            "index",
            "lauser",
            "alaba",
            "whatever",
            "test",
            "test2",
            "google",
            "",
            "empty",
            "xxx",
            "juventus",
            "sturm",
            "gak",
            "index"
        ]
        
        let wordDistance = WordDistance(words: words)
        
        XCTAssertEqual(wordDistance.distance(first: "test", second: "index"), 1)
        XCTAssertEqual(wordDistance.distance(first: "test", second: "test2"), 1)
        XCTAssertEqual(wordDistance.distance(first: "test", second: "google"), 2)
        XCTAssertEqual(wordDistance.distance(first: "test", second: "lauser"), 2)
        XCTAssertEqual(wordDistance.distance(first: "sturm", second: "index"), 2)
        XCTAssertEqual(wordDistance.distance(first: "juventus", second: "gak"), 2)
        XCTAssertEqual(wordDistance.distance(first: "lauser", second: "gak"), 11)
        XCTAssertEqual(wordDistance.distance(first: "index", second: "index"), 0)
        XCTAssertEqual(wordDistance.distance(first: "", second: "index"), 6)
        XCTAssertEqual(wordDistance.distance(first: "test", second: "test3"), nil)
        XCTAssertEqual(wordDistance.distance(first: "test3", second: "index"), nil)
        XCTAssertEqual(wordDistance.distance(first: "wrong", second: "right"), nil)
    }
}
