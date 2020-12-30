//
//  DuplicateRemoverTest.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 10.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation


import XCTest
@testable import DataStructuresAlgorithms

open class LoopDetectorTests: XCTestCase {
    
    open func testLoopDetector() throws {
        let linkedList = SingleLinkedList<Int>()
        
        let loopStartNode = SingleNode(val: 3)
        let loopBackLinkNode = SingleNode(val: 5)
        loopBackLinkNode.next = loopStartNode
        
        linkedList.add(node: SingleNode(val: 1))
        linkedList.add(node: SingleNode(val: 2))
        linkedList.add(node: loopStartNode)
        linkedList.add(node: SingleNode(val: 4))
        linkedList.add(node: loopBackLinkNode)
        
        let loopDetector = LoopDetector<Int>()
        let foundLoopStartNode = loopDetector.detectLoop(linkedList: linkedList)
        
        XCTAssertTrue(loopStartNode === foundLoopStartNode)
    }
}
