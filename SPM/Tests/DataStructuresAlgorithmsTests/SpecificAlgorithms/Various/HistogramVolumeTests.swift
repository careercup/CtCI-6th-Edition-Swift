//
//  HistogramVolumeTests.swift
//  
//
//  Created by Stefan Jaindl on 18.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class HistogramVolumeTests: XCTestCase {
    
    open func testVolume() {
        let volumer = HistogramVolume()
        
        XCTAssertEqual(volumer.volume(of: [3, 1, 4, 0, 0, 6, 0, 3, 0, 2]), 15)
        XCTAssertEqual(volumer.volume(of: [0, 0, 4, 0, 0, 6, 0, 0, 3, 0, 5, 0, 1, 0, 0, 0]), 26)
    }
}
