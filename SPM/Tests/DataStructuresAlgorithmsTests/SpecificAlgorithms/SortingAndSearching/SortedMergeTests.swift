//
//  SortedMergeTests.swift
//  
//
//  Created by Stefan Jaindl on 19.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class SortedMergeTests: XCTestCase {
    
    open func testSortedMerge() {
        let sorter = SortedMerge<Int>()
        var first = [1, 3, 3, 5, 7, 10, nil, nil, nil]
        var second: [Int?] = [2, 3, 12]
        let expected = [1, 2, 3, 3, 3, 5, 7, 10, 12]
        
        sorter.sortAndMerge(first: &first, second: &second)
        XCTAssertEqual(first, expected)
    }
}
