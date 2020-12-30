//
//  IntToEnglishStringTests.swift
//  
//
//  Created by Stefan Jaindl on 20.11.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class IntToEnglishStringTests: XCTestCase {
    open func testEnglishString() throws {
        let converter = IntToEnglishString()
        
        XCTAssertEqual(try converter.convertToEnglishString(number: 0), "Zero")
        XCTAssertEqual(try converter.convertToEnglishString(number: 1), "One")
        XCTAssertEqual(try converter.convertToEnglishString(number: 10), "Ten")
        XCTAssertEqual(try converter.convertToEnglishString(number: 12), "Twelve")
        XCTAssertEqual(try converter.convertToEnglishString(number: 20), "Twenty")
        XCTAssertEqual(try converter.convertToEnglishString(number: 25), "Twenty Five")
        XCTAssertEqual(try converter.convertToEnglishString(number: 100), "One Hundred")
        XCTAssertEqual(try converter.convertToEnglishString(number: 102), "One Hundred Two")
        XCTAssertEqual(try converter.convertToEnglishString(number: 112), "One Hundred Twelve")
        XCTAssertEqual(try converter.convertToEnglishString(number: 1000), "One Thousand")
        XCTAssertEqual(try converter.convertToEnglishString(number: 1002), "One Thousand Two")
        XCTAssertEqual(try converter.convertToEnglishString(number: 10000), "Ten Thousand")
        XCTAssertEqual(try converter.convertToEnglishString(number: 100000), "One Hundred Thousand")
        XCTAssertEqual(try converter.convertToEnglishString(number: 1000000), "One Million")
        XCTAssertEqual(try converter.convertToEnglishString(number: 10000000), "Ten Million")
        XCTAssertEqual(try converter.convertToEnglishString(number: 100000000), "One Hundred Million")
        XCTAssertEqual(try converter.convertToEnglishString(number: 1000000000), "One Billion")
        XCTAssertEqual(try converter.convertToEnglishString(number: 1234567890), "One Billion Two Hundred Thirty Four Million Five Hundred Sixty Seven Thousand Eight Hundred Ninety")
    }
}
