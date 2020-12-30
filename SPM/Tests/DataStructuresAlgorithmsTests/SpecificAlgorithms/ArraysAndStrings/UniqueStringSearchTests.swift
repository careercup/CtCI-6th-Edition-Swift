//
//  UniqueStringSearch.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class UniqueStringSearchTests: XCTestCase {
    
    open func testUniqueStringSearch() {
        let stringSearch = UniqueStringSearch(alphabetSize: 256) //Extended ASCII alphabet
        
        let testString1 = "test"
        XCTAssertFalse(stringSearch.isUniqueStringWithHash(input: testString1))
        XCTAssertFalse(stringSearch.isUniqueStringWithBitVector(input: testString1))
        XCTAssertFalse(stringSearch.isUniqueStringWithSorting(input: testString1))
        
        let testString2 = "string2"
        XCTAssertTrue(stringSearch.isUniqueStringWithHash(input: testString2))
        XCTAssertTrue(stringSearch.isUniqueStringWithBitVector(input: testString2))
        XCTAssertTrue(stringSearch.isUniqueStringWithSorting(input: testString2))
    }
}
