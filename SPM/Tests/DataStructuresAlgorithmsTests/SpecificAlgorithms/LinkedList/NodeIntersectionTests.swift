//
//  NodeIntersectionTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 10.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class NodeIntersectionTests: XCTestCase {
    
    open func testNodeIntersection() throws {
        let firstLinkedList = SingleLinkedList<Int>()
        
        let intersectingNode = SingleNode(val: 4)
        
        firstLinkedList.add(node: SingleNode(val: 1))
        firstLinkedList.add(node: SingleNode(val: 2))
        firstLinkedList.add(node: intersectingNode)
        firstLinkedList.add(node: SingleNode(val: 3))
        
        let secondLinkedList = SingleLinkedList<Int>()
        
        secondLinkedList.add(node: SingleNode(val: 1))
        secondLinkedList.add(node: SingleNode(val: 4))
        secondLinkedList.add(node: SingleNode(val: 3))
        secondLinkedList.add(node: SingleNode(val: 2))
        secondLinkedList.add(node: intersectingNode)
        
        let intersectionChecker = NodeIntersection<Int>()
        let foundIntersectionNode = intersectionChecker.intersect(first: firstLinkedList, second: secondLinkedList)
        
        XCTAssertTrue(foundIntersectionNode === intersectingNode)
    }
}
