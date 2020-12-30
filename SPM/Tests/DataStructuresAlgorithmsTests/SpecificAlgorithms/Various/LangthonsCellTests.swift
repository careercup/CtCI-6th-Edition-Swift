//
//  LangthonsCellTests.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class LangthonsCellTests: XCTestCase {
    
    open func testLangthons() {
        let langthons = Langthons()
        
        let grid = langthons.performMoves(kMoves: 10)
        
        XCTAssertTrue(!grid.isEmpty)
    }
}
