//
//  Stack.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class StackTests: XCTestCase {
    
    open func testStack() throws {
        let stack = Stack<Int>()
        
        stack.push(val: 5)
        stack.push(val: 10)
        
        XCTAssertFalse(stack.isEmpty())
        XCTAssertEqual(try stack.pop(), 10)
        XCTAssertEqual(try stack.pop(), 5)
        XCTAssertTrue(stack.isEmpty())
    }
}
