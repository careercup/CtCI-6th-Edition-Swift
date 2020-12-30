//
//  LivingPeopleTests.swift
//  
//
//  Created by Stefan Jaindl on 23.11.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class LivingPeopleTests: XCTestCase {
    
    open func testLivingPeople() {
        let livingPeople = LivingPeople()
        
        let peoples: [People] = [
            People(name: "", yearOfBirth: 1909, yearOfDeath: 1950),
            People(name: "", yearOfBirth: 1930, yearOfDeath: 1970),
            People(name: "", yearOfBirth: 1920, yearOfDeath: 1990),
            People(name: "", yearOfBirth: 1940, yearOfDeath: nil)
        ]
        
        XCTAssertEqual(livingPeople.yearsWithMostPeopleAlive(peoples: peoples, minYear: 1900), 1940)
    }
}
