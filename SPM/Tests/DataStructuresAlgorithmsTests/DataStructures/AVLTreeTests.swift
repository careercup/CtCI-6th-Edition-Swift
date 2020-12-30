//
//  AVLTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 05.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class AVLTreeTests: XCTestCase {
    
    //Sample Trees from https://www.geeksforgeeks.org/avl-tree-set-1-insertion
    open func testAVLTree() throws {
        let rootValue = 13
        let treeLeftRotate = AVLTree<Int>()

        treeLeftRotate.insert(val: rootValue)
        
        treeLeftRotate.insert(val: 10)
        treeLeftRotate.insert(val: 15)
        
        treeLeftRotate.insert(val: 5)
        treeLeftRotate.insert(val: 11)
        treeLeftRotate.insert(val: 16)
        
        treeLeftRotate.insert(val: 4)
        treeLeftRotate.insert(val: 8)
        
        treeLeftRotate.insert(val: 3)
        
        //right rotation
        var stack = treeLeftRotate.description()
        var array: [String] = []
        while !stack.isEmpty() {
            let element = try stack.pop()
            array.insert(element, at: 0)
        }
        XCTAssertEqual(array,
                       ["13: 4",
                        "5: 3",
                        "4: 2",
                        "3: 1",
                        "10: 2",
                        "8: 1",
                        "11: 1",
                        "15: 2",
                        "16: 1"])
        
        let treeRightRotate = AVLTree<Int>()
        
        treeRightRotate.insert(val: 30)
        
        treeRightRotate.insert(val: 5)
        treeRightRotate.insert(val: 35)
        
        treeRightRotate.insert(val: 32)
        treeRightRotate.insert(val: 40)
        
        treeRightRotate.insert(val: 45)
        
        //left rotation
        stack = treeRightRotate.description()
        array = []
        while !stack.isEmpty() {
            let element = try stack.pop()
            array.insert(element, at: 0)
        }
        XCTAssertEqual(array,
                       ["35: 3",
                        "30: 2",
                        "5: 1",
                        "32: 1",
                        "40: 2",
                        "45: 1"])
        
        let treeLeftRightRotate = AVLTree<Int>()
        
        treeLeftRightRotate.insert(val: 13)
        
        treeLeftRightRotate.insert(val: 10)
        treeLeftRightRotate.insert(val: 15)
        
        treeLeftRightRotate.insert(val: 5)
        treeLeftRightRotate.insert(val: 11)
        treeLeftRightRotate.insert(val: 16)
        
        treeLeftRightRotate.insert(val: 4)
        treeLeftRightRotate.insert(val: 6)
        
        treeLeftRightRotate.insert(val: 7)
      
        //left right rotation
        stack = treeLeftRightRotate.description()
        array = []
        while !stack.isEmpty() {
            let element = try stack.pop()
            array.insert(element, at: 0)
        }
        XCTAssertEqual(array,
                       ["13: 4",
                        "6: 3",
                        "5: 2",
                        "4: 1",
                        "10: 2",
                        "7: 1",
                        "11: 1",
                        "15: 2",
                        "16: 1"])
        
        let treeRightLeftRotate = AVLTree<Int>()
        
        treeRightLeftRotate.insert(val: 5)
        
        treeRightLeftRotate.insert(val: 2)
        treeRightLeftRotate.insert(val: 7)
        
        treeRightLeftRotate.insert(val: 1)
        treeRightLeftRotate.insert(val: 4)
        treeRightLeftRotate.insert(val: 6)
        treeRightLeftRotate.insert(val: 9)
        
        treeRightLeftRotate.insert(val: 3)
        treeRightLeftRotate.insert(val: 16)
        
        treeRightLeftRotate.insert(val: 15)
        
        //right left rotation
        stack = treeRightLeftRotate.description()
        array = []
        while !stack.isEmpty() {
            let element = try stack.pop()
            array.insert(element, at: 0)
        }
        XCTAssertEqual(array,
                       ["5: 4",
                        "2: 3",
                        "1: 1",
                        "4: 2",
                        "3: 1",
                        "7: 3",
                        "6: 1",
                        "15: 2",
                        "9: 1",
                        "16: 1"])
    }
}
