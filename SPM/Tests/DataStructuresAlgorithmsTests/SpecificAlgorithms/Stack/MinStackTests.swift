//
//  MinStackTests.swift
//  
//
//  Created by Stefan Jaindl on 14.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class MinStackTests: XCTestCase {
    
    open func testMinStack() throws {
        //inits stack with 3x3 capacity:
        let minStack = MinStack<Int>()
        
        minStack.push(value: 1)
        minStack.push(value: 2)
        XCTAssertEqual(try minStack.min(), 1)
        
        minStack.push(value: 3)
        XCTAssertEqual(try minStack.min(), 1)
        
        minStack.push(value: 0)
        XCTAssertEqual(try minStack.min(), 0)
        
        minStack.push(value: 50)
        XCTAssertEqual(try minStack.min(), 0)
    }
}
