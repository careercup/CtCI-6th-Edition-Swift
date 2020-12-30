//
//  PairwiseSwapTests.swift
//  
//
//  Created by Stefan Jaindl on 03.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PairwiseSwapTests: XCTestCase {
    public func testSwap() {
        let number = 0b0100111001
        
        let swapper = PairwiseSwap()
        let swapped = swapper.swapOddEven(number: number)
        
        XCTAssertEqual(swapped, 0b1000110110)
    }
}
