//
//  DeadlockPreventingLockTests.swift
//  
//
//  Created by Stefan Jaindl on 07.10.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class DeadlockPreventingLockTests: XCTestCase {
    
    open func testDeadlockPreventingLock() {
        let v1 = Vertice(id: 0)
        let v2 = Vertice(id: 1)
        let v3 = Vertice(id: 2)
        let v4 = Vertice(id: 3)
        let v5 = Vertice(id: 4)
        let v7 = Vertice(id: 5)
        let v9 = Vertice(id: 6)
        
        let threadOneUsage = [v1, v2, v3, v4]
        let threadTwoUsage = [v1, v3, v5]
        let threadThreeUsage = [v7, v5, v9, v2]
        
        let deadlockChecker = DeadlockPreventingLock(vertices: [v1, v2, v3, v4, v5, v7, v9])
        
        XCTAssertTrue(deadlockChecker.canAddThread(with: RessourceUsage(lockOrder: threadOneUsage)))
        XCTAssertTrue(deadlockChecker.canAddThread(with: RessourceUsage(lockOrder: threadTwoUsage)))
        XCTAssertFalse(deadlockChecker.canAddThread(with: RessourceUsage(lockOrder: threadThreeUsage)))
    }
}
