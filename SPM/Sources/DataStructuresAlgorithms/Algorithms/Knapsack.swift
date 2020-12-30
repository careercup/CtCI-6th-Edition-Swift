//
//  Knapsack.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 26.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

//https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
open class Knapsack {
    
    private var knapsack: [[Int]] = []
    
    public init() { }
    
    open func knapsack(weights: [Int], values: [Int], maxWeight: Int) throws -> Int {
        if values.count != weights.count {
            throw NSError(domain: "Knapsack: values and weights are not of same size", code: 0, userInfo: nil)
        }
        
        //base case: no more weight left OR no values left
        if maxWeight == 0 || values.isEmpty {
            return 0
        }
        
        //compute knapsack without last element
        let knapsackWithoutLastElement = try knapsack(weights: Array(weights[0 ..< weights.count - 1]), values: Array(values[0 ..< values.count - 1]), maxWeight: maxWeight)
        
        //if weight of last > maxWeight, the last element definitely can't be included in knapsack
        if weights[values.count - 1] > maxWeight {
            return knapsackWithoutLastElement
        }
        
        //compute knapsack with last element
        let knapsackWithLastElement = try values[values.count - 1] + knapsack(weights: Array(weights[0 ..< weights.count - 1]), values: Array(values[0 ..< values.count - 1]), maxWeight: maxWeight - weights[weights.count - 1])
        
        //case 1: value at last position in values array may be included in knapsack
        //case 2: value at last position in values array is NOT included in knapsack
        return max(knapsackWithLastElement, knapsackWithoutLastElement)
    }
    
    open func knapsackDynamicProgramming(weights: [Int], values: [Int], maxWeight: Int) throws -> Int {
        if values.count != weights.count {
            throw NSError(domain: "Knapsack: values and weights are not of same size", code: 0, userInfo: nil)
        }
        
        var knapsack = Array(repeating: Array(repeating: -1, count: maxWeight + 1), count: values.count + 1)
        
        for valueIndex in 0 ... values.count {
            for weight in 0 ... maxWeight {
                if valueIndex == 0 || weight == 0 {
                    knapsack[valueIndex][weight] = 0
                } else if weights[valueIndex - 1] > weight {
                    //value doesn't fit it knapsack (too much weight)
                    knapsack[valueIndex][weight] = knapsack[valueIndex - 1][weight]
                } else {
                    //value would fit, take max of both cases:
                    //case 1: value at last position in values array may be included in knapsack
                    //case 2: value at last position in values array is NOT included in knapsack
                    let knapsackWithLastElement = values[valueIndex - 1] + knapsack[valueIndex - 1][weight - weights[valueIndex - 1]]
                    let knapsackWithoutLastElement = knapsack[valueIndex - 1][weight]
                    knapsack[valueIndex][weight] = max(knapsackWithLastElement, knapsackWithoutLastElement)
                }
            }
        }
        
        return knapsack[values.count][maxWeight]
    }
}
