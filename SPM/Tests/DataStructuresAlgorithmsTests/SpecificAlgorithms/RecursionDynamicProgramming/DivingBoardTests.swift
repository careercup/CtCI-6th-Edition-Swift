//
//  DivingBoardTests.swift
//  
//
//  Created by Stefan Jaindl on 22.11.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class DivingBoardTests: XCTestCase {
    
    open func testDivingBoard() {
        let board = DivingBoard(shortPlank: Plank(size: .short(1)), longPlank: Plank(size: .long(2)))

        XCTAssertEqual(board.divingBoard(numberOfPlanks: -1), [])
        XCTAssertEqual(board.divingBoard(numberOfPlanks: 0), [])
        XCTAssertEqual(board.divingBoard(numberOfPlanks: 1), [1, 2])
        XCTAssertEqual(board.divingBoard(numberOfPlanks: 2), [2, 3, 4])
        XCTAssertEqual(board.divingBoard(numberOfPlanks: 3), [3, 4, 5, 6])
        XCTAssertEqual(board.divingBoard(numberOfPlanks: 10),[10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
    }
    
    open func testDivingBoardFast() {
        let board = DivingBoard(shortPlank: Plank(size: .short(1)), longPlank: Plank(size: .long(2)))

        XCTAssertEqual(board.divingBoardFast(numberOfPlanks: -1), [])
        XCTAssertEqual(board.divingBoardFast(numberOfPlanks: 0), [])
        XCTAssertEqual(board.divingBoardFast(numberOfPlanks: 1), [1, 2])
        XCTAssertEqual(board.divingBoardFast(numberOfPlanks: 2), [2, 3, 4])
        XCTAssertEqual(board.divingBoardFast(numberOfPlanks: 3), [3, 4, 5, 6])
        XCTAssertEqual(board.divingBoardFast(numberOfPlanks: 10),[10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20])
    }
}
