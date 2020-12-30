//
//  SubtreeCheckerTests.swift
//  
//
//  Created by Stefan Jaindl on 13.07.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class SubtreeCheckerTests: XCTestCase {
    
    open func testSubtreeChecker() {
        //setup input Tree
        let tree = SimpleTreeNode<Int>(value: 10)
        tree.left = SimpleTreeNode<Int>(value: 8)
        tree.left?.left = SimpleTreeNode<Int>(value: 4)
        tree.left?.right = SimpleTreeNode<Int>(value: 9)
        tree.right = SimpleTreeNode<Int>(value: 12)
        tree.right?.right = SimpleTreeNode<Int>(value: 14)
        tree.right?.left = SimpleTreeNode<Int>(value: 11)
        
        let subtree = SimpleTreeNode<Int>(value: 8)
        subtree.left = SimpleTreeNode<Int>(value: 4)
        subtree.right = SimpleTreeNode<Int>(value: 9)
        
        let subtreeChecker = SubTreeChecker<Int>(nilNodeValue: Int.min)
        
        XCTAssertTrue(subtreeChecker.isSubtree(tree: tree, subtree: subtree))
            
        subtree.left?.right = SimpleTreeNode<Int>(value: 99)
        XCTAssertFalse(subtreeChecker.isSubtree(tree: tree, subtree: subtree))
    }
}
