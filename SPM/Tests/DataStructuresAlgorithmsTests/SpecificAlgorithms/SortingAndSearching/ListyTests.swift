//
//  ListyTests.swift
//  
//
//  Created by Stefan Jaindl on 21.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class ListyTests: XCTestCase {
    
    open func testListy() {
        let array = [1, 1, 3, 5, 7, 10]
        let listy = Listy<Int>(array: array)
        let listySearcher = ListySearcher<Int>()
        
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 1), 0)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 3), 2)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 5), 3)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 7), 4)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 10), 5)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 6), nil)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 0), nil)
        XCTAssertEqual(listySearcher.listySearch(listy: listy, searched: 12), nil)
        
    }
}
