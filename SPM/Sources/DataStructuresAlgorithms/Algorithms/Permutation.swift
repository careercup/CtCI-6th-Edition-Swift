//
//  Permutation.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

//https://www.topcoder.com/generating-permutations/
open class Permuation<T> {
    
    public init() { }
    
    open func permutations(array: inout [T]) -> [[T]] {
        if array.isEmpty {
            return []
        }
        
        var generatedPermutations: [[T]] = []
        permutations(array: &array, currentArrayCount: array.count, generatedPermutations: &generatedPermutations)
        return generatedPermutations
    }
    
    private func permutations(array: inout [T], currentArrayCount: Int, generatedPermutations: inout [[T]]) {
        if currentArrayCount == 1 {
            generatedPermutations.append(array)
            return
        } else {
            for count in 0 ..< currentArrayCount {
                swap(array: &array, from: count, to: currentArrayCount - 1)
                permutations(array: &array, currentArrayCount: currentArrayCount - 1, generatedPermutations: &generatedPermutations)
                swap(array: &array, from: count, to: currentArrayCount - 1)
            }
        }
    }
    
    open func heapsPermutations(array: inout [T]) -> [[T]] {
        if array.isEmpty {
            return []
        }
        
        var permutations: [[T]] = []
        
        heapsPermutations(array: &array, currentArrayCount: array.count, permutations: &permutations)
        return permutations
    }
    
    private func heapsPermutations(array: inout [T], currentArrayCount: Int, permutations: inout [[T]]) {
        if currentArrayCount == 1 {
            permutations.append(array)
            return
        } else {
            for count in 0 ..< currentArrayCount - 1 {
                heapsPermutations(array: &array, currentArrayCount: currentArrayCount - 1, permutations: &permutations)
                if currentArrayCount % 2 == 0 {
                    swap(array: &array, from: count, to: currentArrayCount - 1)
                } else {
                    swap(array: &array, from: 0, to: currentArrayCount - 1)
                }
            }
        }
        heapsPermutations(array: &array, currentArrayCount: currentArrayCount - 1, permutations: &permutations)
    }
    
    private func swap(array: inout [T], from: Int, to: Int) {
        let temp = array[from]
        array[from] = array[to]
        array[to] = temp
    }
}
