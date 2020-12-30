//
//  Queue.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class QueueTests: XCTestCase {
    
    open func testQueue() throws {
        let queue = Queue<Int>()
        
        queue.enqueue(val: 1)
        queue.enqueue(val: 2)
        
        var element = try queue.dequeue()
        XCTAssertEqual(element, 1)
        
        element = try queue.dequeue()
        XCTAssertEqual(element, 2)
    }
}
