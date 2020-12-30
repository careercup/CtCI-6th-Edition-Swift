//
//  MaxBlackTests.swift
//  
//
//  Created by Stefan Jaindl on 19.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class MaxBlackTests: XCTestCase {
    
    
    open func testMaxBlackBorder() {
        let maxBlacker = MaxBlack()
        
        var cells = [
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()]
        ]
        
        var square = BlackWhiteSquare(cells: cells)
        var max = maxBlacker.maxBorder(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 0, col: 1), bottomRight: CellIndex(row: 3, col: 4)))

        cells = [
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), white()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()]
        ]

        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBorder(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 0, col: 1), bottomRight: CellIndex(row: 2, col: 3)))

        cells = [
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), black(), white()],
            [white(), white(), black(), black(), white()],
            [white(), black(), black(), black(), white()],
            [white(), white(), white(), white(), black()]
        ]

        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBorder(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 2, col: 2), bottomRight: CellIndex(row: 3, col: 3)))

        cells = [
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), black()]
        ]

        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBorder(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 4, col: 4), bottomRight: CellIndex(row: 4, col: 4)))
        
        cells = [
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()]
        ]
        
        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBorder(of: square)
        
        XCTAssertEqual(max, nil)
    }
    
    open func testMaxBlack() {
        let maxBlacker = MaxBlack()
        
        var cells = [
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()]
        ]
        
        var square = BlackWhiteSquare(cells: cells)
        var max = maxBlacker.maxBlackFilled(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 0, col: 1), bottomRight: CellIndex(row: 4, col: 4)))

        cells = [
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), white()],
            [white(), black(), black(), black(), black()],
            [white(), black(), black(), black(), black()]
        ]

        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBlackFilled(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 0, col: 1), bottomRight: CellIndex(row: 4, col: 3)))

        cells = [
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), black(), white()],
            [white(), white(), black(), black(), white()],
            [white(), black(), black(), black(), white()],
            [white(), white(), white(), white(), black()]
        ]

        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBlackFilled(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 2, col: 2), bottomRight: CellIndex(row: 3, col: 3)))

        cells = [
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), black()]
        ]

        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBlackFilled(of: square)

        XCTAssertEqual(max, SubSquare(topLeft: CellIndex(row: 4, col: 4), bottomRight: CellIndex(row: 4, col: 4)))
        
        cells = [
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()],
            [white(), white(), white(), white(), white()]
        ]
        
        square = BlackWhiteSquare(cells: cells)
        max = maxBlacker.maxBlackFilled(of: square)
        
        XCTAssertEqual(max, nil)
    }
    
    private func black() -> SquareCell {
        return SquareCell(color: .black)
    }
    
    private func white() -> SquareCell {
        return SquareCell(color: .white)
    }
}
