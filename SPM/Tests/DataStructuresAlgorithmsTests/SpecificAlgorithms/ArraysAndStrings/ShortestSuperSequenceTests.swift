//
//  ShortestSuperSequenceTests.swift
//  
//
//  Created by Stefan Jaindl on 12.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class ShortestSuperSequenceTests: XCTestCase {
    
    open func testShortestSequence() {
        let sequencer = ShortestSuperSequence<Int>()
        let biggerArray = [1, 7, 5, 2, 10, 1, 2, 8, 11, 3, 2]
        
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [1, 7, 5], in: biggerArray), SuperSequenceIndexPair(start: 0, end: 2))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [1, 5, 7], in: biggerArray), SuperSequenceIndexPair(start: 0, end: 2))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [7, 5, 2], in: biggerArray), SuperSequenceIndexPair(start: 1, end: 3))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [2, 7, 1], in: biggerArray), SuperSequenceIndexPair(start: 0, end: 3))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [8, 11, 3], in: biggerArray), SuperSequenceIndexPair(start: 7, end: 9))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [3, 11, 8], in: biggerArray), SuperSequenceIndexPair(start: 7, end: 9))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [8, 3, 1], in: biggerArray), SuperSequenceIndexPair(start: 5, end: 9))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [8, 2, 2], in: biggerArray), SuperSequenceIndexPair(start: 3, end: 7))
        XCTAssertEqual(sequencer.findShortestSuperSequence(of: [1, 2, 2, 2, 1], in: biggerArray), SuperSequenceIndexPair(start: 0, end: 10))
    }
}
