//
//  SparseSearch.swift
//  
//
//  Created by Stefan Jaindl on 23.09.20.
//

import Foundation

open class SparseSearch {
    public init() { }
    
    open func sparseSearch(array: [String], searched: String) -> Int? {
        guard !array.isEmpty, !searched.isEmpty else {
            return nil
        }
        
        return sparseSearch(array: array, searched: searched, low: 0, high: array.count - 1)
    }
    
    private func sparseSearch(array: [String], searched: String, low: Int, high: Int) -> Int? {
        let center = low + (high - low) / 2
        if array[center] == searched {
            return center
        }
        
        if high <= low {
            return nil
        }
        
        var newIndex = center
        
        //First, move right to skip blank strings
        while newIndex < high - 1, array[newIndex] == "" {
            newIndex += 1
        }
        
        //If there are no valid strings on the right side, go to left side
        if array[newIndex] == "" {
            newIndex = center
            while newIndex > low + 1, array[newIndex] == "" {
                newIndex -= 1
            }
        }
        
        //.. Alternatively, we could go 1 index left & right simultaneously until we find a non-empty string
        
        //If we haven't found a valid string, string isn't in array
        if array[newIndex] == "" {
            return nil
        }
        
        if array[newIndex] == searched {
            return newIndex
        } else if array[newIndex] < searched {
            return sparseSearch(array: array, searched: searched, low: max(center, newIndex) + 1, high: high)
        } else { //array[newIndex] > searched
            return sparseSearch(array: array, searched: searched, low: low, high: min(center, newIndex) - 1)
        }
    }
}
