//
//  BitInserterTests.swift
//  
//
//  Created by Stefan Jaindl on 23.07.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BitInserterTests: XCTestCase {
    
    open func testBitsInsertion() {
        let bitInserter = BitInserter()
        
        let baseNumber = 0b10000010000
        let numberToInsert = 0b10011
        
        let newNumber = bitInserter.insert(numberToInsert, into: baseNumber, fromBitIndex: 2, toBitIndex: 6)
        
        XCTAssertEqual(newNumber, 0b10001001100)
    }
}
