//
//  QuickSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 29.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class QuickSort<T: Comparable> {
    public static func quickSort(array: inout [T]) {
        if array.count <= 1 {
            return
        }
        
        quickSort(array: &array, min: 0, max: array.count - 1)
    }
    
    private static func quickSort(array: inout [T], min: Int, max: Int) {
        if min < max {
            let pivot = partition(array: &array, min: min, max: max)
            quickSort(array: &array, min: min, max: pivot - 1)
            quickSort(array: &array, min: pivot + 1, max: max)
        }
    }
    
    private static func partition(array: inout [T], min: Int, max: Int) -> Int {
        var left = min + 1
        var pivot = medianOfThree(array: array, min: min, max:  max)
        exchange(array: &array, index1: pivot, index2: min)
        pivot = min
        var right = max
        
        while true {
            while array[left] < array[pivot] {
                left += 1
                if left == max {
                    break
                }
            }
             
            while array[right] > array[pivot] {
                right -= 1
                if right == min {
                    break
                }
            }
            
            if left >= right {
                break
            }
            
            if !(array[left] < array[right]), !(array[right] < array[left]) {
                right -= 1
            } else {
                exchange(array: &array, index1: left, index2: right)
            }
        }
        
        exchange(array: &array, index1: pivot, index2: right)
        pivot = right
        
        return pivot
    }
    
    private static func medianOfThree(array: [T], min: Int, max: Int) -> Int {
        let middle = min + (max - min) / 2
        
        if array[min] < array[middle] && array[min] > array[max]
            || array[min] > array[middle] && array[min] < array[max] {
            return min
        }
        
        if array[max] < array[middle] && array[max] > array[min]
            || array[max] > array[middle] && array[max] < array[min] {
            return max
        }
        
        return middle
    }
    
    private static func exchange(array: inout [T], index1: Int, index2: Int) {
        let temp = array[index1]
        array[index1] = array[index2]
        array[index2] = temp
    }
}
