//
//  PathSum.swift
//  
//
//  Created by Stefan Jaindl on 15.07.20.
//

import Foundation

open class PathSum {

    public init() { }
    
    open func pathSumCount(root: SimpleTreeNode<Int>, valueToMatch: Int) -> Int {
        var sums = [Int: Int]()
        return sumUp(root: root, sums: &sums, offset: 0, valueToMatch: valueToMatch)
    }
    
    //Traverse all nodes and call traverse to check paths from each node
    private func sumUp(root: SimpleTreeNode<Int>?, sums: inout [Int: Int], offset: Int, valueToMatch: Int) -> Int {
        guard let root = root else {
            return 0
        }
        
        return traverse(root: root, sums: &sums, offset: offset, runningSum: 0, valueToMatch: valueToMatch) + sumUp(root: root.left, sums: &sums, offset: offset + root.value, valueToMatch: valueToMatch) + sumUp(root: root.right, sums: &sums, offset: offset + root.value, valueToMatch: valueToMatch)
    }
    
    //Traverse down from a given root
    private func traverse(root: SimpleTreeNode<Int>?, sums: inout [Int: Int], offset: Int, runningSum: Int, valueToMatch: Int) -> Int {
        guard let root = root else {
            return 0
        }
        
        let currentSum = runningSum + root.value
        
        //Sums maps from running sum to node count (that sum to that value)
        if let sumForCount = sums[currentSum] {
            sums[currentSum] = sumForCount + 1
        } else {
            sums[currentSum] = 1
        }
        
        let matching = currentSum == valueToMatch ? 1 : 0
        
        return matching + traverse(root: root.left, sums: &sums, offset: offset, runningSum: currentSum, valueToMatch: valueToMatch) + traverse(root: root.right, sums: &sums, offset: offset, runningSum: currentSum, valueToMatch: valueToMatch)
    }
}
