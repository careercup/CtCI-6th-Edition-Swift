//
//  KToLastTest.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation


import XCTest
@testable import DataStructuresAlgorithms

open class KToLastTest: XCTestCase {
    
    open func testKToLast() throws {
        let linkedList = SingleLinkedList<Int>()
        
        let root = SingleNode(val: 1)
        linkedList.add(node: root)
        linkedList.add(node: SingleNode(val: 5))
        linkedList.add(node: SingleNode(val: 3))
        linkedList.add(node: SingleNode(val: 4))
        linkedList.add(node: SingleNode(val: 10))
        
        let kToLast = KToLast<Int>()
        let kToLastNode = kToLast.kToLast(linkedList: linkedList, k: 2)
        
        XCTAssertEqual(kToLastNode?.val, 3)
    }
}
