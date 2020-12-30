//
//  RotatedArraySearch.swift
//  
//
//  Created by Stefan Jaindl on 21.09.20.
//

import Foundation

open class RotatedArraySearch<T: Comparable> {
    public init() { }
    
    open func search(array: [T], searched: T) -> Int? {
        guard !array.isEmpty else {
            return nil
        }
        
        return search(array: array, searched: searched, low: 0, high: array.count - 1)
    }
    
    private func search(array: [T], searched: T, low: Int, high: Int) -> Int? {
        let center = low + (high - low) / 2
        if array[center] == searched {
            return center
        }
        
        if high <= low {
            return nil
        }
        
        //search for ordered half
        if array[low] < array[center] {
            //left half is ordered
            if array[low] <= searched && searched <= array[center] {
                //within left range
                return search(array: array, searched: searched, low: low, high: center - 1)
            } else {
                //not within left range - search right
                return search(array: array, searched: searched, low: center + 1, high: high)
            }
        } else if array[high] > array[center] {
            //right half is ordered
            if array[center] <= searched && searched <= array[high] {
                //within right range
                return search(array: array, searched: searched, low: center + 1, high: high)
            } else {
                //not within right range - search left
                return search(array: array, searched: searched, low: low, high: center - 1)
            }
        } else {
            //could be on both sides
            if array[high] != array[center] {
                return search(array: array, searched: searched, low: center + 1, high: high)
            } else {
                if let result = search(array: array, searched: searched, low: center + 1, high: high) {
                    return result
                }
                return search(array: array, searched: searched, low: low, high: center - 1)
            }
        }
    }
}
