//
//  DuplicateRemoverTest.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation


import XCTest
@testable import DataStructuresAlgorithms

open class DuplicateRemoverTests: XCTestCase {
    
    open func testDuplicateRemoval() throws {
        let linkedList = SingleLinkedList<Int>()
        
        let root = SingleNode(val: 1)
        linkedList.add(node: root)
        linkedList.add(node: SingleNode(val: 3))
        linkedList.add(node: SingleNode(val: 2))
        linkedList.add(node: SingleNode(val: 3))
        linkedList.add(node: SingleNode(val: 5))
        linkedList.add(node: SingleNode(val: 1))
        
        let duplicateRemover = DuplicateRemover<Int>()
        duplicateRemover.removeDuplicates(linkedList: linkedList)
        
        var result: [Int] = []
        while !linkedList.isEmpty() {
            result.insert(try linkedList.removeLast()!.val, at: 0)
        }
        
        XCTAssertEqual(result, [1, 3, 2, 5])
    }
}
