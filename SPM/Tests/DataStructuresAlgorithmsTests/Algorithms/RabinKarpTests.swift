//
//  RabinKarp.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 04.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class RabinKarpSubstringSearchTests: XCTestCase {

    open func testRabinKarp() {
        let rabinKarp = RabinKarpSubstringSearch(base: 128)
        
        XCTAssertNil(rabinKarp.substr(of: "xxx", in: "Substring"))
        XCTAssertNil(rabinKarp.substr(of: "", in: "Substring"))
        XCTAssertNil(rabinKarp.substr(of: "string", in: "str"))
        
        XCTAssertEqual(rabinKarp.substr(of: "Sub", in: "Substring"), 0)
        XCTAssertEqual(rabinKarp.substr(of: "str", in: "Substring"), 3)
        XCTAssertEqual(rabinKarp.substr(of: "a", in: "Travel Companion"), 2)
    }
}
