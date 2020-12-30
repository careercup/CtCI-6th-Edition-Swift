//
//  IntersectionFinder.swift
//  
//
//  Created by Stefan Jaindl on 15.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class IntersectionFinderTests: XCTestCase {
    
    open func testIntersection() {
        let intersectionFinder = IntersectionFinder()
        
        var first = LineSegment(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 4, y: 4))
        var second = LineSegment(from: CGPoint(x: 1, y: 2), to: CGPoint(x: 3, y: 4))
        
        XCTAssertEqual(intersectionFinder.intersection(firstLine: first, secondLine: second), nil)
        
        first = LineSegment(from: CGPoint(x: 0, y: 0), to: CGPoint(x: 4, y: 4))
        second = LineSegment(from: CGPoint(x: 1, y: 3), to: CGPoint(x: 3, y: 1))
        
        XCTAssertEqual(intersectionFinder.intersection(firstLine: first, secondLine: second), CGPoint(x: 2, y: 2))
    }
}
