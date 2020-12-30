//
//  SortedMatrixSearchTests.swift
//  
//
//  Created by Stefan Jaindl on 26.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class SortedMatrixSearchTests: XCTestCase {
    
    open func testSortedMatrixSearch() {
        var matrix = [[1, 2, 3],
                      [3, 3, 5],
                      [3, 5, 6],
                      [7, 8, 10]]
        
        let matrixSearcher = SortedMatrixSearch<Int>()
        
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 0))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 1))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 2))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 3))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 4))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 5))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 6))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 7))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 8))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 9))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 10))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 11))
        
        matrix = [[1, 2, 4,  4],
                  [2, 3, 5,  8],
                  [3, 5, 8,  8],
                  [5, 8, 9,  10],
                  [7, 9, 10, 12]]
        
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 0))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 1))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 2))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 3))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 4))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 5))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 6))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 7))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 8))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 9))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 10))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 11))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearch(matrix: matrix, searched: 12))
    }
    
    open func testSortedMatrixSearchFaster() {
        var matrix = [[1, 2, 4,  4],
                      [2, 3, 5,  8],
                      [3, 5, 8,  8],
                      [5, 8, 9,  10],
                      [7, 9, 10, 12]]
        
        let matrixSearcher = SortedMatrixSearch<Int>()
        
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 0))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 1))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 2))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 3))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 4))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 5))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 6))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 7))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 8))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 9))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 10))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 11))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 12))
        
        matrix = [[1, 2, 3],
                  [3, 3, 5],
                  [3, 5, 6],
                  [7, 8, 10]]
        
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 0))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 1))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 2))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 3))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 4))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 5))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 6))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 7))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 8))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 9))
        XCTAssertTrue(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 10))
        XCTAssertFalse(matrixSearcher.sortedMatrixSearchFaster(matrix: matrix, searched: 11))
    }
}
