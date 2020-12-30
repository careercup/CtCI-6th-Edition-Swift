//
//  IndexedMinPriorityQueue.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 15.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class IndexedMinPriorityQueueTests: XCTestCase {
   
    open func testIndexedMinPriorityQueue() throws {
        let indexPq = IndexedMinPriorityQueue<Int>(maxElements: 10)
        
        try indexPq.insert(index: 4, key: 8)
        try indexPq.insert(index: 5, key: 10)
        try indexPq.insert(index: 3, key: 6)
        try indexPq.insert(index: 1, key: 2)
        try indexPq.insert(index: 2, key: 4)
        
        try indexPq.changeKey(index: 1, key: 10)
        try indexPq.decreaseKey(index: 5, key: 2)
        
        XCTAssertNotNil(try indexPq.minKey())
        XCTAssertEqual(try indexPq.minKey(), 2)
        XCTAssertEqual(try indexPq.minIndex(), 5)
        XCTAssertEqual(try indexPq.extractMin(), 2)
        
        try indexPq.increaseKey(index: 2, key: 7)
        
        XCTAssertEqual(try indexPq.extractMin(), 6)
        
        try indexPq.delete(index: 4)
        XCTAssertEqual(try indexPq.extractMin(), 7)
        XCTAssertEqual(try indexPq.extractMin(), 10)
        XCTAssertTrue(indexPq.isEmpty())
    }
}
