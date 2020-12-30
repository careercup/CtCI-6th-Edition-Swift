//
//  MultiStackTests.swift
//  
//
//  Created by Stefan Jaindl on 14.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class MultiStackTests: XCTestCase {
    
    open func testMultiStack() throws {
        //inits stack with 3x3 capacity:
        let multiStack = MultiStack<Int>(numberOfStacks: 3, len: 9)
        
        try multiStack.push(stackNumber: 0, element: 1)
        try multiStack.push(stackNumber: 0, element: 2)
        XCTAssertFalse(multiStack.isEmpty(stackNumber: 0))
        XCTAssertTrue(multiStack.isEmpty(stackNumber: 1))
        
        try multiStack.push(stackNumber: 0, element: 3)
        
        //Cause array to shift elements for stack 1:
        try multiStack.push(stackNumber: 0, element: 4)
        
        XCTAssertEqual(try multiStack.peek(stackNumber: 0), 4)
        XCTAssertEqual(try multiStack.pop(stackNumber: 0), 4)
        XCTAssertEqual(try multiStack.pop(stackNumber: 0), 3)
        XCTAssertEqual(try multiStack.pop(stackNumber: 0), 2)
        XCTAssertEqual(try multiStack.pop(stackNumber: 0), 1)
        XCTAssertTrue(multiStack.isEmpty(stackNumber: 0))
    }
}
