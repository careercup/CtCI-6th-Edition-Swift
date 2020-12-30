//
//  ValidateBSTTests.swift
//  
//
//  Created by Stefan Jaindl on 28.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class ValidateBSTTests: XCTestCase {
    
    open func testValidTree() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 5)
        root.left = SimpleTreeNode<Int>(value: 3)
        root.left?.left = SimpleTreeNode<Int>(value: 3)
        root.left?.right = SimpleTreeNode<Int>(value: 4)
        
        root.right = SimpleTreeNode<Int>(value: 7)
        root.right?.right = SimpleTreeNode<Int>(value: 10)
        root.right?.left = SimpleTreeNode<Int>(value: 6)
        
        let validator = BSTValidator<Int>()
        XCTAssertTrue(validator.isValidBST(root: root))
    }
    
    open func testInvalidTree() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 5)
        root.left = SimpleTreeNode<Int>(value: 4)
        root.left?.left = SimpleTreeNode<Int>(value: 3)
        root.left?.right = SimpleTreeNode<Int>(value: 6)
        
        root.right = SimpleTreeNode<Int>(value: 7)
        root.right?.right = SimpleTreeNode<Int>(value: 8)
        
        let validator = BSTValidator<Int>()
        XCTAssertFalse(validator.isValidBST(root: root))
    }
}
