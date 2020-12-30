//
//  WordTransformerTests.swift
//  
//
//  Created by Stefan Jaindl on 18.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class WordTransformerTests: XCTestCase {
    
    open func testTransform() {
        let words: Set<String> = ["damp", "lamp", "limp", "lime", "like"]
        let transformer = WordTransformer(words: words)
        
        XCTAssertEqual(transformer.transform("damp", into: "like"), ["damp", "lamp", "limp", "lime", "like"])
    }
}
