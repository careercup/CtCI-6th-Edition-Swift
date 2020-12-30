//
//  DeleteMiddleNodeTest.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class DeleteMiddleNodeTest: XCTestCase {
    
    open func testDeleteMiddleNode() throws {
        let linkedList = SingleLinkedList<Int>()
        
        let root = SingleNode(val: 1)
        let secondNode = SingleNode(val: 2)
        linkedList.add(node: root)
        linkedList.add(node: secondNode)
        linkedList.add(node: SingleNode(val: 3))
        linkedList.add(node: SingleNode(val: 4))
        linkedList.add(node: SingleNode(val: 5))
        
        let nodeDeleter = DeleteMiddleNode<Int>()
        nodeDeleter.deleteNode(node: secondNode)
        linkedList.count -= 1
        
        var result: [Int] = []
        while !linkedList.isEmpty() {
            result.insert(try linkedList.removeLast()!.val, at: 0)
        }
        
        XCTAssertEqual(result, [1, 3, 4, 5])
    }
}
