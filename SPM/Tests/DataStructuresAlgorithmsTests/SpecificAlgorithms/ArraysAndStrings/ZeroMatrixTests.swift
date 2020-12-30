//
//  ZeroMatrixTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 19.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class ZeroMatrixTests: XCTestCase {
    
    open func testZeroMatrix() {
        let zeroer = ZeroMatrix()
        
        var matrix = [[1, 2,  0],
                      [4, 5,  6],
                      [7, 8,  0],
                      [9, 10, 11]]
        
        let zeroedMatrix = [[0, 0,  0],
                            [4, 5,  0],
                            [0, 0,  0],
                            [9, 10, 0]]
        
        zeroer.zeroMatrix(matrix: &matrix)
        
        XCTAssertEqual(matrix, zeroedMatrix)
    }
}
