//
//  StringRotationTests.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 20.05.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class StringRotationTests: XCTestCase {
    
    open func testStringRotation() {
        let rotationTester = StringRotation()
        
        XCTAssertTrue(rotationTester.isRotation(firstString: "waterbottle", secondString: "bottlewater"))
        XCTAssertTrue(rotationTester.isRotation(firstString: "waterbottle", secondString: "terbottlewa"))
        XCTAssertFalse(rotationTester.isRotation(firstString: "waterbottle", secondString: "terbottlew"))
        XCTAssertFalse(rotationTester.isRotation(firstString: "waterbottle", secondString: "waterbottle"))
    }
}
