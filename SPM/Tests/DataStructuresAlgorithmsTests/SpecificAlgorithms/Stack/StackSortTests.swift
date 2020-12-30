//
//  SortStackTests.swift
//  
//
//  Created by Stefan Jaindl on 14.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class StackSortTests: XCTestCase {
    
    open func testSortStack() throws {
        let stack = Stack<Int>()
        stack.push(val: 3)
        stack.push(val: 1)
        stack.push(val: 5)
        stack.push(val: 2)
        
        StackSort.sort(stack: stack)
        
        var result: [Int] = []
        while !stack.isEmpty() {
            result.append(try stack.pop())
        }
        
        XCTAssertEqual(result, [1, 2, 3, 5])
    }
}
