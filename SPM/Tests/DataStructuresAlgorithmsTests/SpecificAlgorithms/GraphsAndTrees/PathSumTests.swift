//
//  PathSumTests.swift
//  
//
//  Created by Stefan Jaindl on 15.07.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class PathSumTests: XCTestCase {
    
    open func testPathSum() {
        let root = SimpleTreeNode<Int>(value: 3)
        root.left = SimpleTreeNode<Int>(value: 1)
        root.left?.left = SimpleTreeNode<Int>(value: 1)
        root.left?.left?.left = SimpleTreeNode<Int>(value: 4)
        root.left?.left?.right = SimpleTreeNode<Int>(value: 6)
        root.left?.left?.left?.left = SimpleTreeNode<Int>(value: 1)
        
        root.right = SimpleTreeNode<Int>(value: 2)
        root.right?.right = SimpleTreeNode<Int>(value: -1)
        root.right?.right?.right = SimpleTreeNode<Int>(value: 1)
        
        let pathSum = PathSum()
        
        let count = pathSum.pathSumCount(root: root, valueToMatch: 5)
        
        XCTAssertEqual(count, 5)
        
        /* Result BST:
                                                3 (root)
                                        1                   2
                                 1                               -1
                          4             6                              1
                    1
         */
    }
}
