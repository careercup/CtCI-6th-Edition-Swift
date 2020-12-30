//
//  AnagramGrouper.swift
//  
//
//  Created by Stefan Jaindl on 20.09.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class AnagramGrouperTests: XCTestCase {
    
    open func testAnagramGrouper() {
        let grouper = AnagramGrouper()
        let array = ["test", "ets", "xx", "sett", "ste"]
        
        let grouped = grouper.sortAnagram(array: array)
        var lastElement = ""
        for (index, element) in grouped.enumerated() {
            if element == "xx" || index == 0 || index == 4 {
                lastElement = element
                continue
            }
            
            if element == "test" {
                XCTAssertTrue(lastElement == "sett" || grouped[index + 1] == "sett")
            } else if element == "sett" {
                XCTAssertTrue(lastElement == "test" || grouped[index + 1] == "test")
            } else if element == "ets" {
                XCTAssertTrue(lastElement == "ste" || grouped[index + 1] == "ste")
            } else if element == "ste" {
                XCTAssertTrue(lastElement == "ets" || grouped[index + 1] == "ets")
            }
            
            lastElement = element
        }
    }
}
