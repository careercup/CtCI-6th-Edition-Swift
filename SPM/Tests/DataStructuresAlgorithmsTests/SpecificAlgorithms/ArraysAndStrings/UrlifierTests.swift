//
//  UrlifierTests.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 10.05.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class UrlifierTests: XCTestCase {
    
    open func testUrlify() {
        let urlifier = Urlifier()
        
        var string: [Character] = Array("Mr DJ")
        urlifier.urlify(&string)
        XCTAssertEqual(Array("Mr%20DJ"), string)
        
        var string2: [Character] = Array("Mr John Smith")
        urlifier.urlify(&string2)
        XCTAssertEqual(Array("Mr%20John%20Smith"), string2)
        
        var emptyString: [Character] = []
        urlifier.urlify(&emptyString)
        XCTAssertEqual(Array(""), emptyString)
    }
}
