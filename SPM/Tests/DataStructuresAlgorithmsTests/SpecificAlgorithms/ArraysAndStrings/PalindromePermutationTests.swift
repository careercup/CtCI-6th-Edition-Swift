//
//  PalindromePermutationTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 14.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PalindromePermutationTests: XCTestCase {
    
    open func testPalindromePermutations() {
        let palindromePermuation = PalindromePermutation(alphabetSize: 256) //Extended ASCII alphabet
        
        let testString1 = "TACTCOA"
        let testString2 = "BEER"
        XCTAssertTrue(palindromePermuation.isPalindromePermutation(input: testString1))
        XCTAssertFalse(palindromePermuation.isPalindromePermutation(input: testString2))
    }
}
