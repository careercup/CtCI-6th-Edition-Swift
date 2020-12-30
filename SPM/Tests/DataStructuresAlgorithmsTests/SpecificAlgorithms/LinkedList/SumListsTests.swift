//
//  DeleteMiddleNodeTest.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 03.06.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class SumListsTests: XCTestCase {
    
    open func testSumWithPadding() throws {
        let first = SingleNode<Int>(val: 5)
        first.next = SingleNode<Int>(val: 1)
        first.next?.next = SingleNode<Int>(val: 2)
        
        let second = SingleNode<Int>(val: 0)
        second.next = SingleNode<Int>(val: 9)
        second.next?.next = SingleNode<Int>(val: 2)
        
        let summarizer = SumLists()
        let sum = summarizer.sumNodes(first: first, second: second)
        
        var result: [Int] = []
        while !sum.isEmpty() {
            result.insert(try sum.removeLast()!.val, at: 0)
        }
        
        XCTAssertEqual(result, [6, 0, 4])
    }
    
    open func testSumWithExcessCarry() throws {
        let first = SingleNode<Int>(val: 7)
        first.next = SingleNode<Int>(val: 1)
        first.next?.next = SingleNode<Int>(val: 7)
        
        let second = SingleNode<Int>(val: 2)
        second.next = SingleNode<Int>(val: 9)
        second.next?.next = SingleNode<Int>(val: 5)
        
        let summarizer = SumLists()
        let sum = summarizer.sumNodes(first: first, second: second)
        
        var result: [Int] = []
        while !sum.isEmpty() {
            result.insert(try sum.removeLast()!.val, at: 0)
        }
        
        XCTAssertEqual(result, [1, 0, 1, 2])
    }
    
    open func testReverseSum() throws {
        let first = SingleNode<Int>(val: 9)
        first.next = SingleNode<Int>(val: 7)
        first.next?.next = SingleNode<Int>(val: 8)
        
        let second = SingleNode<Int>(val: 6)
        second.next = SingleNode<Int>(val: 8)
        second.next?.next = SingleNode<Int>(val: 5)
        
        let summarizer = SumLists()
        var sumNode = summarizer.reverseSum(first: first, second: second)
        
        var result: [Int] = []
        while let sum = sumNode {
            result.insert(sum.val, at: 0)
            sumNode = sumNode?.next
        }
        
        XCTAssertEqual(result, [1, 4, 6, 5])
    }
}
