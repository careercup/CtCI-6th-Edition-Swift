//
//  QuickSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 29.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class QuickSortTests: XCTestCase {
    
    open func testQuickSort() {
        var array1 = [2, 6, 5, 3, 8, 7, 1, 0]
        QuickSort<Int>.quickSort(array: &array1)
        XCTAssertEqual(array1, [0, 1, 2, 3, 5, 6, 7, 8])
        
        var array2 = [0, 1, 2, 4, 5]
        QuickSort<Int>.quickSort(array: &array2)
        XCTAssertEqual(array2, [0, 1, 2, 4, 5])
        
        var array3 = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        QuickSort<Int>.quickSort(array: &array3)
        XCTAssertEqual(array3, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9])
        
        var array4: [Int] = []
        QuickSort<Int>.quickSort(array: &array4)
        XCTAssertEqual(array4, [])
    }
    
    open func testLargeArrayWithUniqueItems() {
        var array = [4, 4, 8, 8, 8, 8, 11, 11, 7, 7, 4, 4, 2, 2, 9, 9, 14, 14, 10, 10, 2, 2, 1, 1, 6, 6, 7, 7]
        
        QuickSort<Int>.quickSort(array: &array)
        XCTAssertEqual(array,
                       [1, 1, 2, 2, 2, 2, 4, 4, 4, 4, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 10, 10, 11, 11, 14, 14])
    }
    
    open func testSmallArrayWithUniqueItems() {
        var array = [4, 4, 7, 8, 8, 9, 9]
        
        QuickSort<Int>.quickSort(array: &array)
        XCTAssertEqual(array,
                       [4, 4, 7, 8, 8, 9, 9])
    }
}
