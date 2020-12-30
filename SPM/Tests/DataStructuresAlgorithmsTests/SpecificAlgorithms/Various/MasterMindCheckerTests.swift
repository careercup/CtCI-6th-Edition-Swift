//
//  MasterMindCheckerTests.swift
//  
//
//  Created by Stefan Jaindl on 27.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class MasterMindCheckerTests: XCTestCase {
    
    open func testMasterMindChecker() throws {
        let checker = MasterMindChecker()
        
        let guess: [MasterMindColor] = [
            .blue, .blue, .yellow, .red
        ]
        
        let solution: [MasterMindColor] = [
            .yellow, .blue, .green, .red
        ]
        
        XCTAssertEqual(try checker.check(guess: guess, solution: solution), MasterMindCheckResult(hits: 2, pseudohits: 1))
    }
}
