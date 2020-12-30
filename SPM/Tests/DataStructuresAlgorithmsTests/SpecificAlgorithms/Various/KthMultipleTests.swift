//
//  KthMultipleTests.swift
//  
//
//  Created by Stefan Jaindl on 07.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class KthMultipleTests: XCTestCase {
    
    open func testMultiples() throws {
        let multipler = KthMultiple(multiples: [3, 5, 7])
        
        XCTAssertEqual(multipler.allToKthMultipleComposedOfOnlyLowestOddPrimes(k: 25), [1, 3, 5, 7, 9, 15, 21, 25])
        XCTAssertEqual(multipler.allToKthMultipleComposedOfOnlyLowestOddPrimesFast(k: 25), [1, 3, 5, 7, 9, 15, 21, 25])
        
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 0), nil)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 1), 1)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 2), 3)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 3), 5)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 4), 7)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 5), 9)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 6), 15)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 7), 21)
        XCTAssertEqual(try multipler.kthMultipleComposedOfOnlyLowestOddPrimes(k: 8), 25)
    }
}
