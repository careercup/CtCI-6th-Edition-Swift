//
//  PondSizesTests.swift
//  
//
//  Created by Stefan Jaindl on 29.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PondSizesTests: XCTestCase {
    
    open func testPatterns() {
        let pondSizes = PondSizes()
        let matrix = [[0, 2, 1, 0],
                      [0, 1, 0, 1],
                      [1, 1, 0, 1],
                      [0, 1, 0, 1]]
        
        XCTAssertEqual(pondSizes.sizes(matrix: matrix), [2, 4, 1])
    }
}
