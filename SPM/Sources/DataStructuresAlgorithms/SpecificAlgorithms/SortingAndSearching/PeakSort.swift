//
//  PeakSort.swift
//  
//
//  Created by Stefan Jaindl on 29.09.20.
//

import Foundation

open class PeakSort<T: Comparable> {
    public init() { }
    
    open func sort(array: inout [T]) {
        var index = 0
        
        while index < array.count {
            if array.count - 1 > index {
                //If there's only 1 element left, we don't need to sort it.
                //We want the peak (higher or equal element to appear first)
                if array[index + 1] > array[index] {
                    array.swapAt(index, index + 1)
                }
            }
            
            //Check and fix previous misplacement
            if index > 0 && array[index - 1] > array[index] {
                array.swapAt(index - 1, index)
            }
            
            index += 2
        }
    }
}
