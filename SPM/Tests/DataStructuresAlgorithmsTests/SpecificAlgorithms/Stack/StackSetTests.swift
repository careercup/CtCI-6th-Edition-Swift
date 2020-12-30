//
//  StackSetTests.swift
//  
//
//  Created by Stefan Jaindl on 21.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class StackSetTests: XCTestCase {
    
    open func testStackSet() throws {
        let stackSet = StackSet<Int>(treshold: 3)
        
        try stackSet.push(element: 1)
        try stackSet.push(element: 2)
        try stackSet.push(element: 3)
        
        //push on 2nd stack:
        try stackSet.push(element: 4)
        try stackSet.push(element: 5)
        
        XCTAssertEqual(try stackSet.pop(at: 0), 3)
        XCTAssertEqual(try stackSet.pop(at: 1), 5)
        XCTAssertEqual(try stackSet.pop(), 4)
    }
}
