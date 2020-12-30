//
//  MinTreeTests.swift
//  
//
//  Created by Stefan Jaindl on 23.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class MinTreeTests: XCTestCase {
    
    open func testMinTree() throws {
        
        let array = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20]
        let minTreeBuilder = MinTree<Int>()
        
        let root = try minTreeBuilder.minTree(array: array)
        
        //Check in pre-order:
        XCTAssertEqual(root.value, 10)
        XCTAssertEqual(root.left?.value, 5)
        XCTAssertEqual(root.left?.left?.value, 2)
        XCTAssertEqual(root.left?.left?.left?.value, 1)
        XCTAssertEqual(root.left?.left?.right?.value, 3)
        XCTAssertEqual(root.left?.left?.right?.right?.value, 4)
        XCTAssertEqual(root.left?.right?.value, 7)
        XCTAssertEqual(root.left?.right?.left?.value, 6)
        XCTAssertEqual(root.left?.right?.right?.value, 8)
        XCTAssertEqual(root.left?.right?.right?.right?.value, 9)
        
        XCTAssertEqual(root.right?.value, 15)
        XCTAssertEqual(root.right?.left?.value, 12)
        XCTAssertEqual(root.right?.left?.left?.value, 11)
        XCTAssertEqual(root.right?.left?.right?.value, 13)
        XCTAssertEqual(root.right?.left?.right?.right?.value, 14)
        XCTAssertEqual(root.right?.right?.value, 18)
        XCTAssertEqual(root.right?.right?.left?.value, 16)
        XCTAssertEqual(root.right?.right?.left?.right?.value, 17)
        XCTAssertEqual(root.right?.right?.right?.value, 19)
        XCTAssertEqual(root.right?.right?.right?.right?.value, 20)
        
        /* Result BST:
                                            10 (root)
                            5                                           15
                    2               7                           12              18
                1       3       6       8                   11      13      16      19
                          4               9                            14      17
         */
    }
}
