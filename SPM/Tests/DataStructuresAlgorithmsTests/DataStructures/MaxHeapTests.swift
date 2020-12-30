//
//  MaxHeapTests.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MaxHeapTests: XCTestCase {
    
    open func testMaxHeap() throws {
        let heap = MaxHeap<Int>()
        
        heap.insert(val: 1)
        heap.insert(val: 5)
        heap.insert(val: 2)
        heap.insert(val: 10)
        heap.insert(val: -5)
        
        XCTAssertEqual(try heap.peekMax(), 10)
        XCTAssertEqual(try heap.extractMax(), 10)
        XCTAssertEqual(try heap.extractMax(), 5)
        XCTAssertEqual(try heap.extractMax(), 2)
        XCTAssertEqual(try heap.extractMax(), 1)
        
        heap.insert(val: 11)
        heap.insert(val: 7)
        
        XCTAssertEqual(try heap.extractMax(), 11)
        XCTAssertEqual(try heap.extractMax(), 7)
        XCTAssertEqual(try heap.extractMax(), -5)
    }
    
    open func testMaxHeapEqualValues() throws {
        let heap = MaxHeap<Int>()
        let test = [1, 1, 2, 7, 6, 8, 4, 7, 8, 8, 10, 10, 11, 11,
                    9, 7, 6, 4, 2, 4, 8, 9, 4, 2, 2, 7, 14, 14]
        
        for value in test {
            heap.insert(val: value)
        }
        
        var lastElement = Int.max
        while !heap.isEmpty() {
            let element = try heap.extractMax()
            XCTAssertGreaterThanOrEqual(lastElement, element)
            lastElement = element
        }
    }
}
