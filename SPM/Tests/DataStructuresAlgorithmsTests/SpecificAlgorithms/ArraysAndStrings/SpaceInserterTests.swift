//
//  SpaceInserterTests.swift
//  
//
//  Created by Stefan Jaindl on 10.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class SpaceInserterTests: XCTestCase {
    
    open func testSpaceInserter() {
        let spacer = SpaceInserter()
        
        let spaced = spacer.insertSpaces(into: "ihaveaccidentallydeletedallthespacesintheallmightystring",
                                         wordsDict: ["i", "have", "accidentally", "deleted", "all", "spaces", "allmighty", "string", "in"])
        
        XCTAssertEqual(spaced, "i have accidentally deleted all the spaces in the allmighty string")
    }
}
