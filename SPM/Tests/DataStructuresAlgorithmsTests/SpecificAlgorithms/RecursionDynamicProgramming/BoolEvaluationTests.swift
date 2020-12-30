//
//  BoolEvaluationTests.swift
//  
//
//  Created by Stefan Jaindl on 27.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BoolEvaluationTests: XCTestCase {
    
    open func testEvaluation() throws {
        let boolEvaluator = BoolEvaluation()
        let result = try boolEvaluator.boolEvaluation(expression: "1|1|1", expectedResult: true)
        XCTAssertEqual(result, 2)

        let result2 = try boolEvaluator.boolEvaluation(expression: "1^0|0|1", expectedResult: false)
        XCTAssertEqual(result2, 2)
        
        let result3 = try boolEvaluator.boolEvaluation(expression: "0&0&0&1^1|0", expectedResult: true)
        XCTAssertEqual(result3, 10)
    }
}
