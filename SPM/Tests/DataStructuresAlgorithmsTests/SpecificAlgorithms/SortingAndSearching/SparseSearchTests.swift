//
//  SparseSearchTests.swift
//  
//
//  Created by Stefan Jaindl on 23.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class SparseSearchTests: XCTestCase {
    
    open func testSparseSearch() {
        let array = ["at", "", "", "", "ball", "", "", "car", "", "", "dad", "", ""]
        let searcher = SparseSearch()
        
        XCTAssertEqual(searcher.sparseSearch(array: array, searched: "at"), 0)
        XCTAssertEqual(searcher.sparseSearch(array: array, searched: "ball"), 4)
        XCTAssertEqual(searcher.sparseSearch(array: array, searched: "car"), 7)
        XCTAssertEqual(searcher.sparseSearch(array: array, searched: "dad"), 10)
        XCTAssertEqual(searcher.sparseSearch(array: array, searched: "not in array"), nil)
        XCTAssertEqual(searcher.sparseSearch(array: array, searched: ""), nil)
    }
}
