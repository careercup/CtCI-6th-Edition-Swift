//
//  NodeSuccessorTests.swift
//  
//
//  Created by Stefan Jaindl on 28.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class NodeSuccessorTests: XCTestCase {
    
    open func testNodeSuccessorCaseOne() {
        let root = setupTree()
        
        let nodeSuccessor = NodeSuccessor<Int>()
        
        XCTAssertEqual(nodeSuccessor.successor(root: root)?.value, 7)
    }
    
    open func testNodeSuccessorCaseTwo() {
        let root = setupTree()
        
        let nodeSuccessor = NodeSuccessor<Int>()
        
        XCTAssertEqual(nodeSuccessor.successor(root: root.left!.left!)?.value, 2)
    }
    
    open func testNodeSuccessorCaseThree() {
        let root = setupTree()
        
        let nodeSuccessor = NodeSuccessor<Int>()
        
        XCTAssertEqual(nodeSuccessor.successor(root: root.left!.right!)?.value, 5)
    }
    
    private func setupTree() -> TreeNode<Int> {
        let root = TreeNode<Int>(value: 5)
        root.left = TreeNode<Int>(value: 2, parent: root)
        root.left?.left = TreeNode<Int>(value: 1, parent: root.left)
        root.left?.right = TreeNode<Int>(value: 3, parent: root.left)
        
        root.right = TreeNode<Int>(value: 8, parent: root)
        root.right?.right = TreeNode<Int>(value: 10, parent: root.right)
        root.right?.left = TreeNode<Int>(value: 7, parent: root.right)
        
        return root
    }
}
