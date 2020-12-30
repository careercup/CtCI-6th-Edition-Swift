//
//  CoinCounter.swift
//  
//
//  Created by Stefan Jaindl on 24.08.20.
//

import Foundation

open class CoinCounter {
    let coins: [Coin]
    var subcounts: [[Int]] = [] //lookup table: amount->coinIndex
    
    public init(coins: [Coin]) {
        self.coins = coins
    }
    
    open func coins(amount: Int) -> Int {
        subcounts = [[Int]](repeating: [Int](repeating: 0, count: coins.count), count: amount + 1)
        return coins(amount: amount, coinIndex: 0)
    }
    
    open func coins(amount: Int, coinIndex: Int) -> Int {
        if subcounts[amount][coinIndex] > 0 {
            return subcounts[amount][coinIndex]
        }
        
        if coinIndex >= coins.count - 1 {
            return 1 //last coin
        }
        
        var ways = 0
        var amountOfCurrentCoin = 0
        let coinValue = coins[coinIndex].value
        //try coin values in desc. order, as long as they <= the remaining amount
        while amountOfCurrentCoin * coinValue <= amount {
            let remainingAmount = amount - amountOfCurrentCoin * coinValue
            ways += coins(amount: remainingAmount, coinIndex: coinIndex + 1)
            amountOfCurrentCoin += 1
        }
        
        subcounts[amount][coinIndex] = ways
        
        return ways
    }
}

public struct Coin: Hashable {
    let id: String
    let value: Int
}
