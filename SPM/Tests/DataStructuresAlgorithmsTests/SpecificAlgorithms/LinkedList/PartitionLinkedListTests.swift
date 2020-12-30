//
//  PartitionLinkedListTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 07.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class PartitionLinkedListTests: XCTestCase {
    
    open func testPartition() throws {
        let linkedList = SingleLinkedList<Int>()
        
        linkedList.add(node: SingleNode(val: 3))
        linkedList.add(node: SingleNode(val: 5))
        linkedList.add(node: SingleNode(val: 8))
        linkedList.add(node: SingleNode(val: 5))
        linkedList.add(node: SingleNode(val: 10))
        linkedList.add(node: SingleNode(val: 2))
        linkedList.add(node: SingleNode(val: 1))
        
        let partitioner = PartitionLinkedList<Int>()
        partitioner.partition(linkedList: linkedList, around: 5)
        
        var result: [Int] = []
        while !linkedList.isEmpty() {
            result.insert(try linkedList.removeLast()!.val, at: 0)
        }
        
        XCTAssertEqual(result, [1, 2, 3, 5, 8, 5, 10])
    }
}
