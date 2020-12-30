//
//  MultiSearchTests.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class MultiSearchTests: XCTestCase {
    
    open func testMultiSearch() {
        let searcher = MultiSearch()
        
        var matches = searcher.multiSearch(in: "large teststring with multiple entries", for: ["large", "test", "nothing", "entries", ""])
        XCTAssertEqual(matches.sorted(), ["large", "test", "entries"].sorted())
        
        matches = searcher.multiSearch(in: "mississsippi", for: ["is", "ppi", "hi", "sis", "i", "ssippi"])
        XCTAssertEqual(matches.sorted(), ["is", "ppi", "sis", "i", "ssippi"].sorted())
    }
}
