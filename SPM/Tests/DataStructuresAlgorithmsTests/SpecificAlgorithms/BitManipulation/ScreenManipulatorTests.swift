//
//  ScreenManipulatorTests.swift
//  
//
//  Created by Stefan Jaindl on 03.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class ScreenManipulatorTests: XCTestCase {
    public func testDrawLine() {
        var screen = [UInt8](repeating: 0, count: 2 * 5)
        
        let screenManipulator = ScreenManipulator()
        screenManipulator.drawLine(screen: &screen, width: 16, x1: 2, x2: 4, y: 1)
        
        let expected: [UInt8] = [0, 0, 0b00111000, 0, 0, 0, 0, 0, 0, 0]
        XCTAssertEqual(expected, screen)
    }
}
