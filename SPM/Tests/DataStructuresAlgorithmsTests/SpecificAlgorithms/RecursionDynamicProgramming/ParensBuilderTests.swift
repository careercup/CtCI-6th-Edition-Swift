//
//  ParensBuilderTests.swift
//  
//
//  Created by Stefan Jaindl on 24.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class ParensBuilderTests: XCTestCase {
    
    open func testParens() {
        let parensBuilder = ParensBuilder()
        let combis = parensBuilder.parens(numberOfBrackets: 3)
        
        XCTAssertEqual(combis, ["()()()", "()(())", "(())()", "(()())", "((()))"])
    }
}
