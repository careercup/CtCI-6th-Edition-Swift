//
//  Permutation.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

//https://www.topcoder.com/generating-permutations/
open class PermuationTests: XCTestCase {
    
    open func testPermutations() {
        let permutation = Permuation<Int>()
        var array = [1,2,3,4]
        
        var permuations = permutation.permutations(array: &array)
        XCTAssertEqual(permuations, [[2, 3, 4, 1], [3, 2, 4, 1], [3, 4, 2, 1], [4, 3, 2, 1], [2, 4, 3, 1], [4, 2, 3, 1], [4, 3, 1, 2], [3, 4, 1, 2], [3, 1, 4, 2], [1, 3, 4, 2], [4, 1, 3, 2], [1, 4, 3, 2], [2, 4, 1, 3], [4, 2, 1, 3], [4, 1, 2, 3], [1, 4, 2, 3], [2, 1, 4, 3], [1, 2, 4, 3], [2, 3, 1, 4], [3, 2, 1, 4], [3, 1, 2, 4], [1, 3, 2, 4], [2, 1, 3, 4], [1, 2, 3, 4]])
        
        permuations = permutation.heapsPermutations(array: &array)
        XCTAssertEqual(permuations, [[1, 2, 3, 4], [2, 1, 3, 4], [3, 1, 2, 4], [1, 3, 2, 4], [2, 3, 1, 4], [3, 2, 1, 4], [4, 2, 1, 3], [2, 4, 1, 3], [1, 4, 2, 3], [4, 1, 2, 3], [2, 1, 4, 3], [1, 2, 4, 3], [1, 3, 4, 2], [3, 1, 4, 2], [4, 1, 3, 2], [1, 4, 3, 2], [3, 4, 1, 2], [4, 3, 1, 2], [4, 3, 2, 1], [3, 4, 2, 1], [2, 4, 3, 1], [4, 2, 3, 1], [3, 2, 4, 1], [2, 3, 4, 1]])
    }
}
