//
//  XMLEncoderTests.swift
//  
//
//  Created by Stefan Jaindl on 24.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class XMLEncoderTests: XCTestCase {
    
    open func testXMLEncoding() throws {
        let encoder = XMLEncoder()
        
        let xml = "<family lastname=\"McDowell\" state=\"CA\"><person firstName=\"Gayle\">Some Message</person></family>"
        let attributesMapping: [String: Int] = [
            "family": 1,
            "firstName": 2,
            "lastname": 3,
            "state": 4,
            "person": 5
        ]
        
        XCTAssertEqual(try encoder.encode(xml: xml, attributesMapping: attributesMapping), "1 3 McDowell 4 CA 5 2 Gayle Some Message 0 0")
    }
}
