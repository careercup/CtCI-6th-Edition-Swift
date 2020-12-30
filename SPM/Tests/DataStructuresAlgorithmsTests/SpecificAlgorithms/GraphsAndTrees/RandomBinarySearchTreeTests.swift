//
//  RandomBinarySearchTreeTests.swift
//  
//
//  Created by Stefan Jaindl on 13.07.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class RandomBinarySearchTreeTests: XCTestCase {
    
    open func testRandomBinarySearchTree() {
        //setup input Tree
        let searchTree = RandomBinarySearchTree<Int>()
        searchTree.insert(value: 5)
        searchTree.insert(value: 2)
        searchTree.insert(value: 7)
        searchTree.insert(value: 10)
        searchTree.insert(value: 11)
        searchTree.insert(value: 12)
        
        XCTAssertNotNil(searchTree.find(value: 5))
        XCTAssertNotNil(searchTree.find(value: 12))
        XCTAssertNil(searchTree.find(value: 8))
        
        searchTree.delete(value: 12)
        XCTAssertNil(searchTree.find(value: 12))
        
        let random1 = searchTree.getRandomNode()
        let random2 = searchTree.getRandomNode()
        let random3 = searchTree.getRandomNode()
        let random4 = searchTree.getRandomNode()
        
        XCTAssertFalse(random1?.value == random2?.value && random2?.value == random3?.value && random3?.value == random4?.value)
    }
}
