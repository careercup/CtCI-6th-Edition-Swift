//
//  SumSwapperTests.swift
//  
//
//  Created by Stefan Jaindl on 30.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class SumSwapperTests: XCTestCase {
    
    open func testSumSwapper() {
        let swapper = SumSwapper()
        
        let first = [4, 2, 2, 1, 1, 2] //sum: 12
        let second = [3, 7, 3, 3] //sum 16
        XCTAssertEqual(swapper.swap(first: first, second: second), Swappable(first: 1, second: 3))
    }
}
