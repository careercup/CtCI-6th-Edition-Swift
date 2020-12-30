//
//  AppointmentTimeOptimizerTests.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class AppointmentTimeOptimizerTests: XCTestCase {
    
    open func testAppointments() {
        let optimizer = AppointmentTimeOptimizer()
        
        let minutes = [30, 15, 60, 75, 45, 15, 15, 45]
        let maxMinutes = optimizer.calculateMaxPossibleAppointmentTime(from: minutes)
        
        XCTAssertEqual(maxMinutes, 180) //30 + 60 + 45 + 45
        
        XCTAssertEqual(optimizer.calculateMaxMinutesIterative(from: minutes), 180) //30 + 60 + 45 + 45
    }
}
