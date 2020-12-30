//
//  BitVector.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BitVectorTests: XCTestCase {
    
    open func testBitVector() {
        let bitVector = BitVector(numberOfBits: 256)
        
        XCTAssertFalse(bitVector.isBitSet(index: 101))
        bitVector.setBit(index: 101)
        XCTAssertTrue(bitVector.isBitSet(index: 101))
        
        bitVector.unsetBit(index: 101)
        XCTAssertFalse(bitVector.isBitSet(index: 101))
    }
}
