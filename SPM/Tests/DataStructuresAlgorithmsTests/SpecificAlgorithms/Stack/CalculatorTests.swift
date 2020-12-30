//
//  CalculatorTests.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class CalculatorTests: XCTestCase {
    
    open func testCalculator() throws {
        let calculator = Calculator()
        
        // 2 * 3 + 5 / 6 * 3 + 15
        let expression: [Calculator.Expression] = [
            .operand(2), .multiply, .operand(3), .plus, .operand(5), .divide, . operand(6), .multiply, .operand(3), .plus, .operand(15)
        ]
        
        let result = try calculator.calculate(expressions: expression)
        XCTAssertEqual(result, 23.5)
    }
}
