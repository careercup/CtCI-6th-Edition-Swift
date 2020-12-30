//
//  IntervalTree.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 19.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class IntervalTreeTests: XCTestCase {
    
    //https://www.geeksforgeeks.org/interval-tree
    open func testIntervalTree() throws {
        let rootValue = Interval(low: 15, high: 20)
        let rootNode = IntervalNode<Int>(interval: rootValue, height: 1)
        let tree: IntervalTree<Int> = IntervalTree<Int>(root: rootNode)
        
        tree.insert(interval: Interval(low: 10, high: 30))
        tree.insert(interval: Interval(low: 5, high: 20))
        tree.insert(interval: Interval(low: 17, high: 19))
        tree.insert(interval: Interval(low: 12, high: 15))
        tree.insert(interval: Interval(low: 30, high: 40))
        
        let stack = tree.description()
        var array: [String] = []
        while !stack.isEmpty() {
            let element = try stack.pop()
            array.insert(element, at: 0)
        }
        XCTAssertEqual(array,
                       ["Low/High: 15-20, Min/Max: 5-40, Height: 3",
                        "Low/High: 10-30, Min/Max: 5-30, Height: 2",
                        "Low/High: 5-20, Min/Max: 5-20, Height: 1",
                        "Low/High: 12-15, Min/Max: 12-15, Height: 1",
                        "Low/High: 17-19, Min/Max: 17-40, Height: 2",
                        "Low/High: 30-40, Min/Max: 30-40, Height: 1"])
        
        var interval = tree.overlapsInterval(interval: Interval(low: 10, high: 30))
        XCTAssertNotNil(interval)
        XCTAssertEqual(interval!.low, 15)
        XCTAssertEqual(interval!.high, 20)
        
        interval = tree.overlapsInterval(interval: Interval(low: 0, high: 5))
        XCTAssertNil(interval)
        
        interval = tree.overlapsInterval(interval: Interval(low: 4, high: 6))
        XCTAssertNotNil(interval)
        XCTAssertEqual(interval!.low, 5)
        XCTAssertEqual(interval!.high, 20)
        
        interval = tree.overlapsInterval(interval: Interval(low: 25, high: 27))
        XCTAssertNotNil(interval)
        XCTAssertEqual(interval!.low, 10)
        XCTAssertEqual(interval!.high, 30)
    }
}
