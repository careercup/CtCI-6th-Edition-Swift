//
//  TripleStepTests.swift
//  
//
//  Created by Stefan Jaindl on 13.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class TripleStepTests: XCTestCase {
    
    open func testTripleSteps() {
        let stepper = TripleStep()
        XCTAssertEqual(stepper.tripleStep(for: 0), 0)
        XCTAssertEqual(stepper.tripleStep(for: 1), 0)
        XCTAssertEqual(stepper.tripleStep(for: 2), 1)
        XCTAssertEqual(stepper.tripleStep(for: 3), 2)
        XCTAssertEqual(stepper.tripleStep(for: 4), 4)
        XCTAssertEqual(stepper.tripleStep(for: 5), 7)
    }
}
