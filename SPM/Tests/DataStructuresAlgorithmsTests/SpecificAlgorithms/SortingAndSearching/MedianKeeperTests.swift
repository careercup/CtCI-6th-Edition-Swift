//
//  MedianKeeperTests.swift
//  
//
//  Created by Stefan Jaindl on 12.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class MedianKeeperTests: XCTestCase {
    
    open func testMedian() {
        let medianer = MedianKeeper<Int>()
        
        XCTAssertEqual(try medianer.median(of: []), nil)
        XCTAssertEqual(try medianer.median(of: [1]), 1)
        XCTAssertEqual(try medianer.median(of: [1, 3]), 2)
        XCTAssertEqual(try medianer.median(of: [1, 2, 3, 4, 5]), 3)
        XCTAssertEqual(try medianer.median(of: [1, 2, 4, 5]), 3)
    }
}
