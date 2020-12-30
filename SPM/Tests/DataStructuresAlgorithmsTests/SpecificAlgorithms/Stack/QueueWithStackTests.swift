//
//  QueueWithStackTests.swift
//  
//
//  Created by Stefan Jaindl on 21.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class QueueWithStackTests: XCTestCase {
    
    open func testQueueWithStacks() throws {
        let queue = QueueWithStacks<Int>()
        
        try queue.enqueue(value: 1)
        try queue.enqueue(value: 2)
        try queue.enqueue(value: 3)
        
        XCTAssertFalse(queue.isEmpty())
        XCTAssertEqual(try queue.dequeue(), 1)
        XCTAssertEqual(try queue.dequeue(), 2)
        XCTAssertEqual(try queue.dequeue(), 3)
        XCTAssertTrue(queue.isEmpty())
    }
}
