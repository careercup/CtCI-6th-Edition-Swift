//
//  GridPathFinderTests.swift
//  
//
//  Created by Stefan Jaindl on 13.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class GridPathFinderTests: XCTestCase {
    
    open func testGridPathFinder() {
        let grid: [[GridCell<Int>]] = [
            [ GridCell(value: 0, isAccessible: true, row: 0, column: 0),
              GridCell(value: 1, isAccessible: true, row: 0, column: 1),
              GridCell(value: 2, isAccessible: true, row: 0, column: 2),
              GridCell(value: 3, isAccessible: true, row: 0, column: 3),
              GridCell(value: 4, isAccessible: true, row: 0, column: 4),
            ],
            [ GridCell(value: 10, isAccessible: true, row: 1, column: 0),
              GridCell(value: 11, isAccessible: true, row: 1, column: 1),
              GridCell(value: 12, isAccessible: true, row: 1, column: 2),
              GridCell(value: 13, isAccessible: true, row: 1, column: 3),
              GridCell(value: 14, isAccessible: true, row: 1, column: 4),
            ],
            [ GridCell(value: 20, isAccessible: false, row: 2, column: 0),
              GridCell(value: 21, isAccessible: true, row: 2, column: 1),
              GridCell(value: 22, isAccessible: false, row: 2, column: 2),
              GridCell(value: 23, isAccessible: true, row: 2, column: 3),
              GridCell(value: 24, isAccessible: true, row: 2, column: 4),
            ],
            [ GridCell(value: 30, isAccessible: true, row: 3, column: 0),
              GridCell(value: 31, isAccessible: true, row: 3, column: 1),
              GridCell(value: 32, isAccessible: true, row: 3, column: 2),
              GridCell(value: 33, isAccessible: true, row: 3, column: 3),
              GridCell(value: 34, isAccessible: true, row: 3, column: 4),
            ],
            [ GridCell(value: 40, isAccessible: true, row: 4, column: 0),
              GridCell(value: 41, isAccessible: true, row: 4, column: 1),
              GridCell(value: 42, isAccessible: false, row: 4, column: 2),
              GridCell(value: 43, isAccessible: true, row: 4, column: 3),
              GridCell(value: 44, isAccessible: true, row: 4, column: 4),
            ],
            [ GridCell(value: 50, isAccessible: true, row: 5, column: 0),
              GridCell(value: 51, isAccessible: true, row: 5, column: 1),
              GridCell(value: 52, isAccessible: false, row: 5, column: 2),
              GridCell(value: 53, isAccessible: false, row: 5, column: 3),
              GridCell(value: 54, isAccessible: false, row: 5, column: 4),
            ],
            [ GridCell(value: 60, isAccessible: true, row: 6, column: 0),
              GridCell(value: 61, isAccessible: true, row: 6, column: 1),
              GridCell(value: 62, isAccessible: true, row: 6, column: 2),
              GridCell(value: 63, isAccessible: true, row: 6, column: 3),
              GridCell(value: 64, isAccessible: true, row: 6, column: 4),
            ]
        ]
        
        let roboterPathFinder = GridPathFinder(grid: grid)
        let path = roboterPathFinder.findPath()
        XCTAssertNotNil(path)
        XCTAssertEqual(path, [0, 1, 11, 21, 31, 41, 51, 61, 62, 63, 64])
    }
}
