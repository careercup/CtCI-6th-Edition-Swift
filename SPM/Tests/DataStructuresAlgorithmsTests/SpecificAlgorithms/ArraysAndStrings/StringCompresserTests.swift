//
//  PalindromePermutationTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 14.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class StringCompresserTests: XCTestCase {
    
    open func testStringCompresser() {
        let stringCompresser = StringCompresser()
        
        XCTAssertEqual(stringCompresser.compress(string: "abc"), "abc")
        XCTAssertEqual(stringCompresser.compress(string: "aabcccccaaa"), "a2b1c5a3")
        XCTAssertEqual(stringCompresser.compress(string: "aabbcc"), "aabbcc")
        XCTAssertEqual(stringCompresser.compress(string: "aabbccc"), "a2b2c3")
    }
}
