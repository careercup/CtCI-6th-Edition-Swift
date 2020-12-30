//
//  PatternMatcherTests.swift
//  
//
//  Created by Stefan Jaindl on 28.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PatternMatcherTests: XCTestCase {
    
    open func testPatterns() {
        let matcher = PatternMatcher()
        
        XCTAssertTrue(matcher.matches(value: "catcatgogo", pattern: [.a, .a, .b, .b]))
        XCTAssertTrue(matcher.matches(value: "catcatgogo", pattern: [.b, .b, .a, .a]))
        XCTAssertTrue(matcher.matches(value: "catcatgogo", pattern: [.b, .a]))
        XCTAssertTrue(matcher.matches(value: "catcatgogo", pattern: [.b]))
        XCTAssertFalse(matcher.matches(value: "catcatgogo", pattern: []))
        XCTAssertFalse(matcher.matches(value: "catcatgogoo", pattern: [.a, .a, .b, .b]))
        XCTAssertFalse(matcher.matches(value: "", pattern: [.a]))
    }
}
