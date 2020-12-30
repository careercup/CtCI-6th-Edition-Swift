//
//  LongestWordFinderTests.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class LongestWordFinderTests: XCTestCase {
    open func testLongest() {
        let finder = LongestWordFinder()
        
        let longest = finder.findLongestCombinedWord(of: ["cat", "banana", "dog", "nana", "walk", "walker", "dogwalker"])
        XCTAssertEqual(longest, "dogwalker")
    }
}
