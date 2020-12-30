//
//  MinHeap.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 25.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MinHeapTests: XCTestCase {
    
    open func testMinHeap() throws {
        let heap = MinHeap<Int>()
        
        heap.insert(val: 1)
        heap.insert(val: 5)
        heap.insert(val: 2)
        heap.insert(val: 10)
        heap.insert(val: -5)
        
        XCTAssertEqual(try heap.peekMin(), -5)
        XCTAssertEqual(try heap.extractMin(), -5)
        XCTAssertEqual(try heap.extractMin(), 1)
        XCTAssertEqual(try heap.extractMin(), 2)
        XCTAssertEqual(try heap.extractMin(), 5)
        
        heap.insert(val: 11)
        heap.insert(val: 7)
        
        XCTAssertEqual(try heap.extractMin(), 7)
        XCTAssertEqual(try heap.extractMin(), 10)
        XCTAssertEqual(try heap.extractMin(), 11)
    }
    
    open func testMinHeapEqualValues() throws {
        let heap = MinHeap<Int>()
        let test = [1, 1, 2, 7, 6, 8, 4, 7, 8, 8, 10, 10, 11, 11,
                    9, 7, 6, 4, 2, 4, 8, 9, 4, 2, 2, 7, 14, 14]
        
        for value in test {
            heap.insert(val: value)
        }
        
        var lastElement = Int.min
        while !heap.isEmpty() {
            let element = try heap.extractMin()
            XCTAssertLessThanOrEqual(lastElement, element)
            lastElement = element
        }
    }
}
