//
//  BinaryToStringConverterTests.swift
//  
//
//  Created by Stefan Jaindl on 27.07.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BinaryToStringConverterTests: XCTestCase {
    
    open func testDoubleConversion() {
        let converter = BinaryToStringConverter()
        
        let number = 0.625
        let binary = converter.binaryRepresentation(of: number)
        XCTAssertEqual(binary, ".101")
    }
}
