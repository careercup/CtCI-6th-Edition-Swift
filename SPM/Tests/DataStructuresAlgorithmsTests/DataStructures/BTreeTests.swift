//
//  BTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 18.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BTreeTests: XCTestCase {
    
    //https://www.geeksforgeeks.org/insert-operation-in-b-tree
    open func testBTree() throws {
        let degree: Int = 3
        let rootNode = BTreeNode<Int>(degree: degree)
        let bTree = BTree<Int>(root: rootNode)
        
        try bTree.insert(key: 10)
        try bTree.insert(key: 20)
        try bTree.insert(key: 30)
        try bTree.insert(key: 40)
        try bTree.insert(key: 50)
        try bTree.insert(key: 60)
        try bTree.insert(key: 70)
        try bTree.insert(key: 80)
        try bTree.insert(key: 90)
        
        let stack = bTree.traverse()
        var array: [Int] = []
        while !stack.isEmpty() {
            let element = try stack.pop()
            array.insert(element, at: 0)
        }
        XCTAssertEqual(array,
                       [10,
                        20,
                        30,
                        40,
                        50,
                        60,
                        70,
                        80,
                        90])
        
        XCTAssertTrue(bTree.search(key: 10))
        XCTAssertTrue(bTree.search(key: 30))
        XCTAssertTrue(bTree.search(key: 50))
        XCTAssertTrue(bTree.search(key: 90))
        XCTAssertFalse(bTree.search(key: 100))
    }
}
