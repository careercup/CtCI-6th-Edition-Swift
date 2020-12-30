//
//  LRUCacheTests.swift
//  
//
//  Created by Stefan Jaindl on 01.12.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class LRUCacheTests: XCTestCase {
    
    open func testCache() {
        
        let cache = LRUCache<Int>(cacheSize: 4)
        
        cache.insert(1)
        cache.insert(2)
        cache.insert(3)
        cache.insert(4)
        
        XCTAssertNotNil(cache.get(1))
        XCTAssertNotNil(cache.get(2))
        XCTAssertNotNil(cache.get(3))
        XCTAssertNotNil(cache.get(4))
        XCTAssertNil(cache.get(5))
        
        cache.insert(5)
        XCTAssertNil(cache.get(1))
        XCTAssertNotNil(cache.get(2))
        XCTAssertNotNil(cache.get(3))
        XCTAssertNotNil(cache.get(4))
        XCTAssertNotNil(cache.get(5))
        
        cache.insert(1)
        XCTAssertNotNil(cache.get(1))
        XCTAssertNil(cache.get(2))
        XCTAssertNotNil(cache.get(3))
        XCTAssertNotNil(cache.get(4))
        XCTAssertNotNil(cache.get(5))
    }
}
