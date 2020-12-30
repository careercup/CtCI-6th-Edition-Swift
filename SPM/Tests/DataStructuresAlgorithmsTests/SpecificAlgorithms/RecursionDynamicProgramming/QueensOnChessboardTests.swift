//
//  QueensOnChessboardTests.swift
//  
//
//  Created by Stefan Jaindl on 25.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class QueensOnChessboardTests: XCTestCase {
    
    open func testQueensArrangements() {
        let queensArranger = QueensOnChessboard()
        let arrangements = queensArranger.queenArrangements()
        
        XCTAssertEqual(arrangements.count, 92)
    }
    
}
