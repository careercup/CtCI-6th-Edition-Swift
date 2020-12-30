//
//  PeakSortTests.swift
//  
//
//  Created by Stefan Jaindl on 29.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class PeakSortTests: XCTestCase {
    
    open func testPeakSort() {
        let peaksort = PeakSort<Int>()
        var array = [1, 5, 2, 4, 6, 3]
        
        peaksort.sort(array: &array)
        XCTAssertEqual(array, [5, 1, 4, 2, 6, 3])
        
        array = [1, 2, 3, 4, 5, 6, 7, 8, 9]
        peaksort.sort(array: &array)
        
        XCTAssertEqual(array, [2, 1, 4, 3, 6, 5, 8, 7, 9])
    }
}
