//
//  BitFlipperTests.swift
//  
//
//  Created by Stefan Jaindl on 27.07.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BitFlipperTests: XCTestCase {
    
    open func testLongestOneBitSequence() {
        let bitFlipper = BitFlipper()
        
        let input = 0b11011101111 //1775
        let longestSequence = bitFlipper.findLongestOneBitSequenceByFlippingMaxOneBit(input: input)
        
        XCTAssertEqual(longestSequence, 8)
    }
}
