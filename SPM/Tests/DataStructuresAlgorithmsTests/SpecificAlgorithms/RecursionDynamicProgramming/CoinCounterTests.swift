//
//  CoinCounterTests.swift
//  
//
//  Created by Stefan Jaindl on 24.08.20.
//

import XCTest
@testable import DataStructuresAlgorithms

open class CoinCounterTests: XCTestCase {
    
    open func testCoinCounter() {
        let coins = [Coin(id: "Quarter", value: 25),
                     Coin(id: "Dime", value: 10),
                     Coin(id: "Nickel", value: 5),
                     Coin(id: "Penny", value: 1)]
        
        let coinCounter = CoinCounter(coins: coins)
        let ways = coinCounter.coins(amount: 15)
        
        XCTAssertEqual(ways, 6)
    }
}
