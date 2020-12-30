//
//  BestLineSearcherTests.swift
//  
//
//  Created by Stefan Jaindl on 26.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class BestLineSearcherTests: XCTestCase {
    
    open func testBestLineSearcher() {
        
        let points: [Point] = [
            Point(x: 2, y: 2),
            Point(x: 4, y: 2),
            Point(x: 5, y: 3),
            Point(x: 6, y: 4),
            Point(x: 0, y: 17)
        ]
        
        let graph = TwoDGraph(points: points)
        let bestLineSearcher = BestLineSearcher()
        
        let line = bestLineSearcher.bestLine(of: graph)
        
        XCTAssertEqual(line, MultiPrecisionLine(startPoint: Point(x: 4, y: 2), endPoint: Point(x: 6, y: 4)))
    }
}
