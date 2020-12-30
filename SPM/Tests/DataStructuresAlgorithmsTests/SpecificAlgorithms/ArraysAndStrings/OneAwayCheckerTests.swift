//
//  PalindromePermutationTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 14.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class OneAwayCheckerTests: XCTestCase {
    
    open func testOneAwayChecker() {
        let oneAwayChecker = OneAwayChecker()
        
        XCTAssertTrue(oneAwayChecker.isOneAway(string1: "pale", string2: "ple"))
        XCTAssertTrue(oneAwayChecker.isOneAway(string1: "pales", string2: "pale"))
        XCTAssertFalse(oneAwayChecker.isOneAway(string1: "pale", string2: "bake"))
        XCTAssertFalse(oneAwayChecker.isOneAway(string1: "test", string2: "test123"))
    }
}
