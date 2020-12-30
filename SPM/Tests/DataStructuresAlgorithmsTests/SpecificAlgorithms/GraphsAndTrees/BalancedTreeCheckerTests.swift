//
//  BalancedTreeCheckerTests.swift
//  
//
//  Created by Stefan Jaindl on 24.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class BalancedTreeCheckerTests: XCTestCase {
    
    open func testUnbalancedTree() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 1)
        root.left = SimpleTreeNode<Int>(value: 2)
        root.right = SimpleTreeNode<Int>(value: 2)
        root.left?.left = SimpleTreeNode<Int>(value: 3)
        root.left?.left?.left = SimpleTreeNode<Int>(value: 4)
        root.left?.right = SimpleTreeNode<Int>(value: 3)
        root.left?.right?.left = SimpleTreeNode<Int>(value: 4)
        root.left?.right?.right = SimpleTreeNode<Int>(value: 4)
        root.left?.right?.right?.left = SimpleTreeNode<Int>(value: 5)
        
        root.right?.right = SimpleTreeNode<Int>(value: 3)
        root.right?.left = SimpleTreeNode<Int>(value: 3)
        
        let balancedChecker = BalancedTreeChecker<Int>()
        XCTAssertFalse(balancedChecker.isBalanced(root: root))
    }
    
    open func testBalancedTree() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 1)
        root.left = SimpleTreeNode<Int>(value: 2)
        root.right = SimpleTreeNode<Int>(value: 2)
        root.left?.left = SimpleTreeNode<Int>(value: 3)
        root.left?.left?.left = SimpleTreeNode<Int>(value: 4)
        root.left?.right = SimpleTreeNode<Int>(value: 3)
        root.left?.right?.left = SimpleTreeNode<Int>(value: 4)
        root.left?.right?.right = SimpleTreeNode<Int>(value: 4)
        root.left?.right?.right?.left = SimpleTreeNode<Int>(value: 5)
        
        root.right?.right = SimpleTreeNode<Int>(value: 3)
        root.right?.left = SimpleTreeNode<Int>(value: 3)
        root.right?.right?.right = SimpleTreeNode<Int>(value: 4) //add node, so that height diff at root is only 1
        
        let balancedChecker = BalancedTreeChecker<Int>()
        XCTAssertTrue(balancedChecker.isBalanced(root: root))
    }
}
