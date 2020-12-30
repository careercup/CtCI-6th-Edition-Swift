//
//  StackOfBoxesTests.swift
//  
//
//  Created by Stefan Jaindl on 26.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class StackOfBoxesTests: XCTestCase {
    
    open func testStackOfBoxes() {
        let stackOfBoxes = StackOfBoxes()
        let boxes = [ Box(width: 10, height: 20, depth: 15),
                      Box(width: 5, height: 15, depth: 20),
                      Box(width: 1, height: 10, depth: 1),
                      Box(width: 30, height: 5, depth: 25)]
        let maxHeight = stackOfBoxes.maxHeight(of: boxes)
        
        XCTAssertEqual(maxHeight, 30)
    }
}
