//
//  NamesMergerTests.swift
//  
//
//  Created by Stefan Jaindl on 06.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class NamesMergerTests: XCTestCase {
    
    open func testMerging1() throws {
        let merger = NamesMerger()
        
        let frequencies = [
            NameFrequency(name: "John", frequency: 15),
            NameFrequency(name: "Jon", frequency: 12),
            NameFrequency(name: "Chris", frequency: 13),
            NameFrequency(name: "Kris", frequency: 4),
            NameFrequency(name: "Christopher", frequency: 19),
            NameFrequency(name: "Christof", frequency: 10),
        ]
        
        let mappings = [("Jon", "John"), ("John", "Johnny"), ("Chris", "Kris"), ("Chris", "Christopher"), ("Christopher", "Christof")]
        
        let mergedFrequencies = try merger.mergeLists(nameFrequencies: frequencies, nameMappings: mappings)
        
        let expectedMergedFrequencies = [
            NameFrequency(name: "John", frequency: 27),
            NameFrequency(name: "Chris", frequency: 46)
        ]
        
        XCTAssertEqual(mergedFrequencies, expectedMergedFrequencies)
    }
    
    open func testMerging2() throws {
        let merger = NamesMerger()
        
        let frequencies = [
            NameFrequency(name: "John", frequency: 10),
            NameFrequency(name: "Jon", frequency: 3),
            NameFrequency(name: "Davis", frequency: 2),
            NameFrequency(name: "Kari", frequency: 3),
            NameFrequency(name: "Johnny", frequency: 11),
            NameFrequency(name: "Carlton", frequency: 8),
            NameFrequency(name: "Carleton", frequency: 2),
            NameFrequency(name: "Jonathan", frequency: 9),
            NameFrequency(name: "Carrie", frequency: 5),
        ]
        
        let mappings = [("Jonathan", "John"), ("Jon", "Johnny"), ("Johnny", "John"), ("Kari", "Carrie"), ("Carleton", "Carlton")]
        
        let mergedFrequencies = try merger.mergeLists(nameFrequencies: frequencies, nameMappings: mappings)
        
        let expectedMergedFrequencies = [
            NameFrequency(name: "John", frequency: 33),
            NameFrequency(name: "Davis", frequency: 2),
            NameFrequency(name: "Kari", frequency: 8),
            NameFrequency(name: "Carlton", frequency: 10)
        ]
        
        XCTAssertEqual(mergedFrequencies, expectedMergedFrequencies)
    }
}
