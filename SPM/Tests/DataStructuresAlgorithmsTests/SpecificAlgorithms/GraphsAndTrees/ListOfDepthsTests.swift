//
//  ListOfDepthsTests.swift
//  
//
//  Created by Stefan Jaindl on 24.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class ListOfDepthsTests: XCTestCase {
    
    open func testListOfDepths() {
        //setup input Tree
        let root = SimpleTreeNode<Int>(value: 3)
        root.left = SimpleTreeNode<Int>(value: 4)
        root.right = SimpleTreeNode<Int>(value: 2)
        root.left?.left = SimpleTreeNode<Int>(value: 1)
        root.left?.right = SimpleTreeNode<Int>(value: 3)
        root.left?.right?.left = SimpleTreeNode<Int>(value: 2)
        root.right?.right = SimpleTreeNode<Int>(value: 7)
        root.right?.right?.right = SimpleTreeNode<Int>(value: 0)
        
        //setup expected result:
        var resultList = Array<SingleLinkedList<Int>>()
        let rootList = SingleLinkedList<Int>()
        let levelTwoList = SingleLinkedList<Int>()
        let levelThreeList = SingleLinkedList<Int>()
        let levelFourList = SingleLinkedList<Int>()
        
        rootList.add(node: SingleNode<Int>(val: 3))
        levelTwoList.add(node: SingleNode<Int>(val: 4))
        levelTwoList.add(node: SingleNode<Int>(val: 2))
        levelThreeList.add(node: SingleNode<Int>(val: 1))
        levelThreeList.add(node: SingleNode<Int>(val: 3))
        levelThreeList.add(node: SingleNode<Int>(val: 7))
        levelFourList.add(node: SingleNode<Int>(val: 2))
        levelFourList.add(node: SingleNode<Int>(val: 0))
        resultList.append(rootList)
        resultList.append(levelTwoList)
        resultList.append(levelThreeList)
        resultList.append(levelFourList)
        
        let listOfDepth = ListOfDepths<Int>()
        let result = listOfDepth.listOfDepths(root: root)
        
        XCTAssertEqual(result.count, 4)
        XCTAssertEqual(result[0].count, rootList.count)
        XCTAssertEqual(result[0].head?.val, rootList.head?.val)
        XCTAssertEqual(result[1].count, levelTwoList.count)
        XCTAssertEqual(result[1].head?.val, levelTwoList.head?.val)
        XCTAssertEqual(result[1].head?.next?.val, levelTwoList.head?.next?.val)
        XCTAssertEqual(result[2].count, levelThreeList.count)
        XCTAssertEqual(result[2].head?.val, levelThreeList.head?.val)
        XCTAssertEqual(result[2].head?.next?.val, levelThreeList.head?.next?.val)
        XCTAssertEqual(result[2].head?.next?.next?.val, levelThreeList.head?.next?.next?.val)
        XCTAssertEqual(result[3].count, levelFourList.count)
        XCTAssertEqual(result[3].head?.val, levelFourList.head?.val)
        XCTAssertEqual(result[3].head?.next?.val, levelFourList.head?.next?.val)
    }
}
