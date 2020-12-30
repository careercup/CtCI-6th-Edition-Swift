//
//  LettersAndNumbersLargestSubsequenceTests.swift
//  
//
//  Created by Stefan Jaindl on 05.12.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class LettersAndNumbersLargestSubsequenceTests: XCTestCase {
    open func testLargestSubsequence() {
        let subSequenceFinder = LettersAndNumbersLargestSubsequence()
        
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: ["1"]), [])
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: []), [])
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: ["1", "a"]), ["1", "a"])
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: ["1", "1", "a"]), ["1", "a"])
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: ["1", "a", "a", "1", "a"]), ["1", "a", "a", "1"])
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: ["a", "1", "a", "a", "1"]), ["1", "a", "a", "1"])
        XCTAssertEqual(subSequenceFinder.findLargestSubSequence(of: ["1", "1", "1", "1", "a", "a", "a", "a", "1", "a", "1", "1", "a", "1", "1"]), ["1", "1", "1", "a", "a", "a", "a", "1", "a", "1", "1", "a"])
    }
}
