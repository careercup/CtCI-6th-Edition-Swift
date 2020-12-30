//
//  NumberSwapperTests.swift
//  
//
//  Created by Stefan Jaindl on 15.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class NumberSwapperTests: XCTestCase {
    
    open func testSwap() {
        let swapper = Swapper<Int>()
        
        var first = 7
        var second = 3
        swapper.swapInline(&first, &second)
        XCTAssertEqual(first, 3)
        XCTAssertEqual(second, 7)
        
        first = -4
        second = 1777
        swapper.swapInline(&first, &second)
        XCTAssertEqual(first, 1777)
        XCTAssertEqual(second, -4)
    }
}
