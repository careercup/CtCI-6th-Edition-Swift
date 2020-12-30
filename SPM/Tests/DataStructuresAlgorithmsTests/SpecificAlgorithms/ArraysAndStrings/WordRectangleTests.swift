//
//  WordRectangleTests.swift
//  
//
//  Created by Stefan Jaindl on 22.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class WordRectangleTests: XCTestCase {
    
    open func testWordRectangle() {
        let maxRectangler = WordRectangle()
        
        /*
         Rectangle:
            ab
            cd
        */
        var words = ["ab", "ac", "cd", "bd"]
        var max = maxRectangler.maxRectangle(of: words)
        XCTAssertTrue(max == ["ab", "cd"] || max == ["ac", "bd"])
        
        /*
         Rectangle:
            gaus
            reto
            arte
            zooy
        */
        words = ["reto", "gaus", "graz", "soey", "maoam", "valid", "mamam", "", "arte", "zooy", "utto", "aero"]
        max = maxRectangler.maxRectangle(of: words)
        XCTAssertTrue(max == ["gaus", "reto", "arte", "zooy"] || max == ["graz", "aero", "utto", "soey"])
    }
}
