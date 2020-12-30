//
//  FizzBuzzTests.swift
//  
//
//  Created by Stefan Jaindl on 09.10.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class FizzBuzzTests: XCTestCase {
    
    open func testFizzBuzz() {
        let fizzBuzz = FizzBuzz(targetNumber: 21)
        fizzBuzz.play()
        
        sleep(2)
        
        XCTAssertEqual(fizzBuzz.fizzBuzzData.result, ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz", "16", "17", "Fizz", "19", "Buzz", "Fizz"])
    }
}
