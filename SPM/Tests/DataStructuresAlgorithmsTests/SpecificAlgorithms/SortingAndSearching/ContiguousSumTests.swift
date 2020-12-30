//
//  ContiguousSumTests.swift
//  
//
//  Created by Stefan Jaindl on 28.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class ContiguousSumTests: XCTestCase {
    
    open func testLargestContiguousSum() {
        
        let summer = ContiguousSum()
        let array = [2, -8, 3, -2, 4, -10]
        
        XCTAssertEqual(summer.largestContiguousSum(of: array), 5)
    }
}
