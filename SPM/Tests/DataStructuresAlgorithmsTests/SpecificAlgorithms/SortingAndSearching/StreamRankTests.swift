//
//  StreamRankTests.swift
//  
//
//  Created by Stefan Jaindl on 27.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class StreamRankTests: XCTestCase {
    
    open func testStreamRank() {
        let ranker = StreamRank<Int>()
        
        ranker.track(value: 5)
        ranker.track(value: 1)
        ranker.track(value: 4)
        ranker.track(value: 4)
        ranker.track(value: 5)
        ranker.track(value: 9)
        ranker.track(value: 7)
        ranker.track(value: 13)
        ranker.track(value: 3)
        
        XCTAssertEqual(ranker.rank(of: 0), 0)
        XCTAssertEqual(ranker.rank(of: 1), 0)
        XCTAssertEqual(ranker.rank(of: 2), 1)
        XCTAssertEqual(ranker.rank(of: 3), 1)
        XCTAssertEqual(ranker.rank(of: 4), 3)
        XCTAssertEqual(ranker.rank(of: 5), 5)
        XCTAssertEqual(ranker.rank(of: 6), 6)
        XCTAssertEqual(ranker.rank(of: 7), 6)
        XCTAssertEqual(ranker.rank(of: 8), 7)
        XCTAssertEqual(ranker.rank(of: 9), 7)
        XCTAssertEqual(ranker.rank(of: 10), 8)
        XCTAssertEqual(ranker.rank(of: 13), 8)
        XCTAssertEqual(ranker.rank(of: 14), 9)
    }
}
