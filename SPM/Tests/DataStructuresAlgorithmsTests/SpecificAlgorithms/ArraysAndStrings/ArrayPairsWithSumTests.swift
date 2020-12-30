//
//  ArrayPairsWithSumTests.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class ArrayPairsWithSumTests: XCTestCase {
    
    open func testPairs() {
        let arrayWithSumPairs = ArrayPairsWithSum()
        let array = [1, 7, 5, 2, 3, 3, 1, 6, 4]
        
        let pairs = arrayWithSumPairs.pairsWithSum(array: array, targetSum: 7)
        
        XCTAssertEqual(pairs.count, 3)
        XCTAssertTrue(pairs.contains(where: { $0 == ArrayPairsWithSum.TargetSumPair(first: 1, second: 6) }))
        XCTAssertTrue(pairs.contains(where: { $0 == ArrayPairsWithSum.TargetSumPair(first: 5, second: 2) }))
        XCTAssertTrue(pairs.contains(where: { $0 == ArrayPairsWithSum.TargetSumPair(first: 3, second: 4) }))
    }
}
