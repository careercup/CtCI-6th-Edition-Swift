//
//  SquareConnectorTests.swift
//  
//
//  Created by Stefan Jaindl on 26.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class SquareConnectorTests: XCTestCase {
    
    open func testSquareConnector() {
        let connector = SquareConnector()
        
        //Slope 1 squares
        var firstSquare = Square(topLeftCorner: CGPoint(x: 2, y: 4), length: 2)
        var secondSquare = Square(topLeftCorner: CGPoint(x: 6, y: 8), length: 2)
        XCTAssertEqual(connector.connect(firstSquare: firstSquare, secondSquare: secondSquare), Line(startPoint: CGPoint(x: 2, y: 2), endPoint: CGPoint(x: 8, y: 8)))
        
        //Same squares - straight line to top through x center
        firstSquare = Square(topLeftCorner: CGPoint(x: 2, y: 4), length: 2)
        secondSquare = Square(topLeftCorner: CGPoint(x: 2, y: 4), length: 2)
        XCTAssertEqual(connector.connect(firstSquare: firstSquare, secondSquare: secondSquare), Line(startPoint: CGPoint(x: 3, y: 2), endPoint: CGPoint(x: 3, y: 4)))
        
        //Stapled squares - straight line to top through x center
        firstSquare = Square(topLeftCorner: CGPoint(x: 2, y: 4), length: 2)
        secondSquare = Square(topLeftCorner: CGPoint(x: 2, y: 6), length: 2)
        XCTAssertEqual(connector.connect(firstSquare: firstSquare, secondSquare: secondSquare), Line(startPoint: CGPoint(x: 3, y: 2), endPoint: CGPoint(x: 3, y: 6)))
        
        //slope > 1 squares
        firstSquare = Square(topLeftCorner: CGPoint(x: 2, y: 4), length: 2)
        secondSquare = Square(topLeftCorner: CGPoint(x: 3, y: 7), length: 2)
        XCTAssertEqual(connector.connect(firstSquare: firstSquare, secondSquare: secondSquare), Line(startPoint: CGPoint(x: 2.6666666666666665, y: 2), endPoint: CGPoint(x: 4.333333333333333, y: 7)))
        
        //slope < 1 squares
        firstSquare = Square(topLeftCorner: CGPoint(x: 2, y: 4), length: 2)
        secondSquare = Square(topLeftCorner: CGPoint(x: 6, y: 5), length: 2)
        XCTAssertEqual(connector.connect(firstSquare: firstSquare, secondSquare: secondSquare), Line(startPoint: CGPoint(x: 2, y: 2.75), endPoint: CGPoint(x: 8, y: 4.25)))
    }
}
