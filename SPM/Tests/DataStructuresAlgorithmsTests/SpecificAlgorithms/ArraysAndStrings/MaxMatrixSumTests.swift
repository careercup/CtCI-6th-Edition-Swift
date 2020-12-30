//
//  MaxMatrixSumTests.swift
//  
//
//  Created by Stefan Jaindl on 20.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MaxMatrixSumTests: XCTestCase {
    
    open func testMaxSum() {
        let summer = MaxMatrixSum()
        
        let matrix = [
            [1,  7, -4, 2],
            [2, -1, -4, 2],
            [3, -3, -4, 2],
            [4,  7, -4, 0]
        ]
        
        let maxRectangle = summer.maxSum(of: matrix)
        XCTAssertEqual(maxRectangle, SubRectangle(topLeft: CellIndex(row: 0, col: 0), bottomRight: CellIndex(row: 3, col: 1)))
    }
}
