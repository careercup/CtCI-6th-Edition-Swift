//
//  BinaryNumberConverterTests.swift
//  
//
//  Created by Stefan Jaindl on 31.07.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class BinaryNumberConverterTests: XCTestCase {
    
    open func testBinaryNumberConverter() {
        let from = 0b1001101
        let   to = 0b0101011
        
        let converter = BinaryNumberConverter()
        let bitDifferentCount = converter.binaryConversionCount(from: from, to: to)
        XCTAssertEqual(bitDifferentCount, 4)
    }
}
