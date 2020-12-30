//
//  CircusTowerTests.swift
//  
//
//  Created by Stefan Jaindl on 06.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class CircusTowerTests: XCTestCase {
    
    open func testMaxTower() {
        let tower = CircusTower()
        
        let people = [
            CircusPeople(width: 65, height: 100),
            CircusPeople(width: 70, height: 150),
            CircusPeople(width: 56, height: 90),
            CircusPeople(width: 75, height: 190),
            CircusPeople(width: 60, height: 85),
            CircusPeople(width: 68, height: 110)
        ]
        
        let size = tower.highestTowerSize(of: people)
        XCTAssertEqual(size, 5)
    }
}
