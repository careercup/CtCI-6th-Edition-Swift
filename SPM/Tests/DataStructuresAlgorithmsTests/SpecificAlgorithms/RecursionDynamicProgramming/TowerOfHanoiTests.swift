//
//  TowerOfHanoiTests.swift
//  
//
//  Created by Stefan Jaindl on 19.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class TowerOfHanoiTests: XCTestCase {
    
    open func testTowersOfHanoi() throws {
        let numberOfTowers = 3
        var towers: [TowerOfHanoi<Int>] = []
        
        for tower in 0 ..< numberOfTowers {
            towers.append(TowerOfHanoi(index: tower))
        }
        
        for diskNr in stride(from: 10, to: 0, by: -1) {
            try towers[0].add(disk: diskNr)
        }
        
        try towers[0].moveDisks(numberOfDisks: 10, destination: towers[2], buffer: towers[1])
        
        var array: [Int] = []
        while !towers[2].disks.isEmpty() {
            let element = try towers[2].disks.pop()
            array.append(element)
        }
        
        XCTAssertEqual(array, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
    }
}
