//
//  PalindromePermutationTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 14.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MatrixRotationTests: XCTestCase {
    
    open func testMatrixRightRotation() {
        let rotator = MatrixRotation()
        
        var oddArray = [[1, 2, 3],
                        [4, 5, 6],
                        [7, 8, 9]]
        
        let rotatedOddArray = [[7, 4, 1],
                               [8, 5, 2],
                               [9, 6, 3]]
        
        var evenArray = [[1, 2, 3, 4],
                         [5, 6, 7, 8],
                         [9, 10, 11, 12],
                         [13, 14, 15, 16]]
        
        let rotatedEvenArray = [[13, 9, 5, 1],
                                [14, 10, 6, 2],
                                [15, 11, 7, 3],
                                [16, 12, 8, 4]]
        
        rotator.rotateRight(array: &oddArray)
        rotator.rotateRight(array: &evenArray)
        
        XCTAssertEqual(oddArray, rotatedOddArray)
        XCTAssertEqual(evenArray, rotatedEvenArray)
    }
}
