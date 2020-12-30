//
//  Knapsack.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 26.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

//https://www.geeksforgeeks.org/0-1-knapsack-problem-dp-10/
open class KnapsackTests: XCTestCase {
    
    open func testKnapsack() {
        let knapsack = Knapsack()
        let weights = [1, 1, 1]
        let values = [20, 10, 30]
        let knapsackMaxValue = try! knapsack.knapsack(weights: weights, values: values, maxWeight: 2)
        let knapsackDynamicMaxValue = try! knapsack.knapsackDynamicProgramming(weights: weights, values: values, maxWeight: 2)
        
        XCTAssertEqual(knapsackMaxValue, 50)
        XCTAssertEqual(knapsackDynamicMaxValue, 50)
        
        let knapsack2 = Knapsack()
        let weights2 = [10, 20, 30]
        let values2 = [60, 100, 120]
        let knapsack2MaxValue = try! knapsack2.knapsack(weights: weights2, values: values2, maxWeight: 50)
        let knapsack2DynamicMaxValue = try! knapsack2.knapsackDynamicProgramming(weights: weights2, values: values2, maxWeight: 50)
        
        XCTAssertEqual(knapsack2MaxValue, 220)
        XCTAssertEqual(knapsack2DynamicMaxValue, 220)
    }
}
