//
//  PaintFillTests.swift
//  
//
//  Created by Stefan Jaindl on 24.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class PaintFillTests: XCTestCase {
    
    open func testPaintFill() throws {
        let paintfill = PaintFill()
        let black = CGColor.black
        let white = CGColor.white
        let red = CGColor.init(red: 255, green: 0, blue: 0, alpha: 1)
        
        var screen = [ [black, white, white, white],
                       [black, black, black, white],
                       [black, white, white, black],
                       [white, white, white, white],
                       [white, white, white, white] ]
        
        let expected = [ [red, white, white, white],
                         [red, red, red, white],
                         [red, white, white, red],
                         [white, white, white, white],
                         [white, white, white, white] ]
        
        try paintfill.paintFill(screen: &screen, point: Point(x: 2, y: 3), newColor: red)
        
        XCTAssertEqual(screen, expected)
    }
}
