//
//  RotatedArraySearchTests.swift
//  
//
//  Created by Stefan Jaindl on 21.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class RotatedArraySearchTests: XCTestCase {
    
    open func testRotatedArraySearch() {
        let searcher = RotatedArraySearch<Int>()
        
        var array = [15, 16, 19, 20, 25, 1, 3, 4, 5, 7, 10, 14]
        XCTAssertEqual(searcher.search(array: array, searched: 5) , 8)
        XCTAssertEqual(searcher.search(array: array, searched: 17) , nil)
        XCTAssertEqual(searcher.search(array: array, searched: 20) , 3)
        
        array = [2, 2, 2, 3, 4, 2]
        XCTAssertEqual(searcher.search(array: array, searched: 2) , 2)
        XCTAssertEqual(searcher.search(array: array, searched: 3) , 3)
        XCTAssertEqual(searcher.search(array: array, searched: 4) , 4)
        
        array = [2, 3, 4, 2, 2, 2]
        XCTAssertEqual(searcher.search(array: array, searched: 2) , 0)
        XCTAssertEqual(searcher.search(array: array, searched: 3) , 1)
        XCTAssertEqual(searcher.search(array: array, searched: 4) , 2)
        
        array = [1, 2, 3, 4, 5, 6, 7, 8]
        XCTAssertEqual(searcher.search(array: array, searched: 1) , 0)
        XCTAssertEqual(searcher.search(array: array, searched: 3) , 2)
        XCTAssertEqual(searcher.search(array: array, searched: 8) , 7)
    }
}
