//
//  DiningPhilosophersTests.swift
//  
//
//  Created by Stefan Jaindl on 07.10.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class DiningPhilosophersTests: XCTestCase {
    
    open func testDiningPhilosophers() {
        let chopstickOne = Chopstick(index: 1)
        let chopstickTwo = Chopstick(index: 2)
        let chopstickThree = Chopstick(index: 3)
        let chopstickFour = Chopstick(index: 4)
        let chopstickFive = Chopstick(index: 5)
        
        var philosophers: [Philosopher] = []
        philosophers.append(Philosopher(name: "Plato", left: chopstickOne, right: chopstickFive))
        philosophers.append(Philosopher(name: "Aristoteles", left: chopstickTwo, right: chopstickOne))
        philosophers.append(Philosopher(name: "Ronaldo", left: chopstickThree, right: chopstickTwo))
        philosophers.append(Philosopher(name: "Messi", left: chopstickFour, right: chopstickThree))
        philosophers.append(Philosopher(name: "Einstein", left: chopstickFive, right: chopstickFour))
        
        for _ in 0 ..< 3 {
            for philosopher in philosophers {
                philosopher.eat()
            }
        }
        
        sleep(4)
        
        XCTAssertEqual(chopstickOne.lockedCount, 6)
    }
}
