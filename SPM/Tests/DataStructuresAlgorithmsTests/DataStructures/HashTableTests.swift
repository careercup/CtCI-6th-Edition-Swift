//
//  HashTable.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 26.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class HashTableTests: XCTestCase {
    
   open func testHashTable() {
        let hashTable = HashTable(size: 2069) //prime number
        
        hashTable.insert(val: "abcdef")
        hashTable.insert(val: "bcdefa")
        
        XCTAssertTrue(hashTable.contains(val: "abcdef"))
        XCTAssertTrue(hashTable.contains(val: "bcdefa"))
        XCTAssertFalse(hashTable.contains(val: "bcdeaf"))
    }
}
