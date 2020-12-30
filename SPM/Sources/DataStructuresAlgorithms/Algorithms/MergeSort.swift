//
//  MergeSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 28.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class MergeSort<T: Comparable> {
    
    public static func mergeSort(array: inout [T]) {
        mergeSort(array: &array, min: 0, max: array.count - 1)
    }
    
    public static func mergeSort(array: inout [T], min: Int, max: Int) {
        if max <= min {
            return
        }
        
        let middle = min + (max - min) / 2
        mergeSort(array: &array, min: min, max: middle)
        mergeSort(array: &array, min: middle + 1, max: max)
        merge(array: &array, min: min, middle: middle, max: max)
    }
    
    private static func merge(array: inout [T], min: Int, middle: Int, max: Int) {
        let aux = array
        var cur = min
        var left = min
        var right = middle + 1
        while cur <= max {
            if left > middle {
                array[cur] = aux[right]
                right += 1
            } else if right > max {
                array[cur] = aux[left]
                left += 1
            } else if aux[left] <= aux[right] {
                array[cur] = aux[left]
                left += 1
            } else {
                array[cur] = aux[right]
                right += 1
            }
            cur += 1
        }
    }
}
