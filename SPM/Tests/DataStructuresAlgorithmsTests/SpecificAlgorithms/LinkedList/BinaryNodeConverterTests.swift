//
//  BinaryNodeConverterTests.swift
//  
//
//  Created by Stefan Jaindl on 09.12.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class BinaryNodeConverterTests: XCTestCase {
    
    open func testConvertion() {
        let converter = BinaryNodeConverter<Int>()
        
        let bstRoot = BiNode<Int>(data: 10)
        bstRoot.left = BiNode<Int>(data: 6)
        bstRoot.left?.left = BiNode<Int>(data: 5)
        bstRoot.left?.right = BiNode<Int>(data: 8)
        bstRoot.left?.right?.left = BiNode<Int>(data: 7)
        bstRoot.left?.right?.right = BiNode<Int>(data: 9)
        
        bstRoot.right = BiNode<Int>(data: 12)
        bstRoot.right?.left = BiNode<Int>(data: 11)
        
        let newRoot = converter.convertBinarySearchTreeToDoubleLinkedList(root: bstRoot)?.left
        
        XCTAssertEqual(newRoot?.data, 5)
        XCTAssertEqual(newRoot?.left, nil)
        XCTAssertEqual(newRoot?.right?.data, 6)
        XCTAssertEqual(newRoot?.right?.left?.data, 5)
        XCTAssertEqual(newRoot?.right?.right?.data, 7)
        XCTAssertEqual(newRoot?.right?.right?.right?.data, 8)
        XCTAssertEqual(newRoot?.right?.right?.right?.right?.data, 9)
        XCTAssertEqual(newRoot?.right?.right?.right?.right?.right?.data, 10)
        XCTAssertEqual(newRoot?.right?.right?.right?.right?.right?.right?.data, 11)
        XCTAssertEqual(newRoot?.right?.right?.right?.right?.right?.right?.right?.data, 12)
        XCTAssertEqual(newRoot?.right?.right?.right?.right?.right?.right?.right?.right, nil)
        XCTAssertEqual(newRoot?.right?.right?.right?.right?.right?.right?.right?.left?.data, 11)
    }
}
