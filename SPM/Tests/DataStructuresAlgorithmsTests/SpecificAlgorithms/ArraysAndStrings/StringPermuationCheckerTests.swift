//
//  StringPermutationCheckerTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 09.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class StringPermutationCheckerTests: XCTestCase {
    
    open func testStringPermutations() {
        let permuationChecker = StringPermuationChecker(alphabetSize: 256) //Extended ASCII alphabet
        
        var testString1 = "MAOAM"
        var testString2 = "AMAMO"
        XCTAssertTrue(permuationChecker.isPermutationOfByCharArray(first: testString1, second: testString2))
        XCTAssertTrue(permuationChecker.isPermutationOfBySorting(first: testString1, second: testString2))
        
        testString1 = "MAO"
        testString2 = "OMO"
        XCTAssertFalse(permuationChecker.isPermutationOfByCharArray(first: testString1, second: testString2))
        XCTAssertFalse(permuationChecker.isPermutationOfBySorting(first: testString1, second: testString2))
            
        testString1 = "MAO"
        testString2 = "MA"
        XCTAssertFalse(permuationChecker.isPermutationOfByCharArray(first: testString1, second: testString2))
        XCTAssertFalse(permuationChecker.isPermutationOfBySorting(first: testString1, second: testString2))
    }
}
