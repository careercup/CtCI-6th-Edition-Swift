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

open class LinkedListPalindromeTests: XCTestCase {
    
    open func testPalindromeEven() throws {
        let linkedList = SingleLinkedList<Character>()
        
        linkedList.add(node: SingleNode(val: "1"))
        linkedList.add(node: SingleNode(val: "2"))
        linkedList.add(node: SingleNode(val: "3"))
        linkedList.add(node: SingleNode(val: "3"))
        linkedList.add(node: SingleNode(val: "2"))
        linkedList.add(node: SingleNode(val: "1"))
        
        let palindromeChecker = LinkedListPalindrome<Character>()
        XCTAssertTrue(palindromeChecker.isPalindrome(linkedList: linkedList))
    }
    
    open func testPalindromeOdd() throws {
        let linkedList = SingleLinkedList<Character>()
        
        linkedList.add(node: SingleNode(val: "M"))
        linkedList.add(node: SingleNode(val: "A"))
        linkedList.add(node: SingleNode(val: "H"))
        linkedList.add(node: SingleNode(val: "A"))
        linkedList.add(node: SingleNode(val: "H"))
        linkedList.add(node: SingleNode(val: "A"))
        linkedList.add(node: SingleNode(val: "M"))
        
        let palindromeChecker = LinkedListPalindrome<Character>()
        XCTAssertTrue(palindromeChecker.isPalindrome(linkedList: linkedList))
    }
}
