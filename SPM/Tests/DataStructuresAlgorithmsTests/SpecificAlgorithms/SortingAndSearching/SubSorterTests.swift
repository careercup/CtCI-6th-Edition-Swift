//
//  SubSorterTests.swift
//  
//
//  Created by Stefan Jaindl on 28.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class SubSorterTests: XCTestCase {
    
    open func testShortestSubsortSequence() {
        let sorter = SubSorter()
        let array = [1, 2, 4, 7, 10, 11, 7, 12, 6, 7, 16, 18, 19] //shortest sequence to sort is from index 3 (=7) to 9 (=7)
        
        XCTAssertEqual(sorter.shortestSubsortRange(of: array), SortRange(from: 3, to: 9))
    }
}
