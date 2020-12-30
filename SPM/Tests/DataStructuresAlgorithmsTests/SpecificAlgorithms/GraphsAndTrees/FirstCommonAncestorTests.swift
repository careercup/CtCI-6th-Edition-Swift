//
//  FirstCommonAncestorTests.swift
//  
//
//  Created by Stefan Jaindl on 30.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class FirstCommonAncestorTests: XCTestCase {
    
    open func testFirstCommonAncestor() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 1)
        root.left = SimpleTreeNode<Int>(value: 4)
        root.right = SimpleTreeNode<Int>(value: 9)
        root.left?.left = SimpleTreeNode<Int>(value: 5)
        root.left?.left?.left = SimpleTreeNode<Int>(value: 6)
        root.left?.right = SimpleTreeNode<Int>(value: 7)
        root.left?.right?.left = SimpleTreeNode<Int>(value: 2)
        
        root.right?.right = SimpleTreeNode<Int>(value: 3)
        root.right?.right?.left = SimpleTreeNode<Int>(value: 8)
        
        let firstCommonAncestorChecker = FirstCommonAncestor<Int>()
        
        var firstCommonAncestor = firstCommonAncestorChecker.firstCommonAncestor(root: root, first: (root.left?.right?.left)!, second: (root.left?.left?.left)!)!
        XCTAssertEqual(firstCommonAncestor.value, root.left?.value) //2, 6 -> 4
     
        firstCommonAncestor = firstCommonAncestorChecker.firstCommonAncestor(root: root, first: (root.left?.right?.left)!, second: (root.left?.right?.left)!)!
        XCTAssertEqual(firstCommonAncestor.value, root.left?.right?.left?.value) //2, 2 -> 2
        
        firstCommonAncestor = firstCommonAncestorChecker.firstCommonAncestor(root: root, first: (root.left?.left?.left)!, second: (root.right?.right?.left)!)!
        XCTAssertEqual(firstCommonAncestor.value, root.value) //6, 8 -> 1
        
        firstCommonAncestor = firstCommonAncestorChecker.firstCommonAncestor(root: root, first: (root.left?.left?.left)!, second: (root.left?.right)!)!
        XCTAssertEqual(firstCommonAncestor.value, root.left?.value) //6, 7 -> 4
        
        firstCommonAncestor = firstCommonAncestorChecker.firstCommonAncestor(root: root, first: (root.left)!, second: (root.left?.left)!)!
        XCTAssertEqual(firstCommonAncestor.value, root.left?.value) //4, 5 -> 4
    }
}
