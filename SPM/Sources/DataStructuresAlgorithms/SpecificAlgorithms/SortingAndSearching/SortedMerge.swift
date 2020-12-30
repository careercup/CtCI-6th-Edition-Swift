//
//  SortedMerge.swift
//  
//
//  Created by Stefan Jaindl on 18.09.20.
//

import Foundation

open class SortedMerge<T: Comparable> {
    
    public init() { }
    
    //Merges second array into first
    //Prerequisites: Both arrays are already sorted AND first array has enough space (nil elements) at the end to hold second array
    func sortAndMerge(first: inout [T?], second: inout [T?]) {
        if first.isEmpty || second.isEmpty {
            return
        }
        
        var firstPos = 0
        
        //Check as long as there is no elements left in first array
        while first.element(at: firstPos) != nil {
            while let firstElement = first.element(at: firstPos), let secondElement = second.element(at: 0), firstElement <= secondElement {
                //move along as long as current element of first array <= current element of second array
                firstPos += 1
            }
            
            if first.element(at: firstPos) == nil {
                //We have sorted elements for first array length
                break
            }
            
            exchange(first: &first, second: &second, firstPos: firstPos, secondPos: 0)
            
            var secondPos = 0
            while secondPos + 1 < second.count, let secondElement = second.element(at: secondPos), let nextSecondElement = second.element(at: secondPos + 1), secondElement > nextSecondElement {
                //Correct order of second array after new element was added in front, as long as necessary
                exchange(array: &second, firstPos: secondPos, secondPos: secondPos + 1)
                
                secondPos += 1
            }
        }
        
        var secondPos = 0
        //Append remaining elements from second array to first (they are sorted and >= current last element of first array)
        while secondPos < second.count {
            first[first.index(at: firstPos)] = second.element(at: secondPos)
            firstPos += 1
            secondPos += 1
        }
    }
    
    private func exchange(array: inout [T?], firstPos: Int, secondPos: Int) {
        let firstValue = array.element(at: firstPos)
        array[array.index(at: firstPos)] = array.element(at: secondPos)
        array[array.index(at: secondPos)] = firstValue
    }
    
    private func exchange(first: inout [T?], second: inout [T?], firstPos: Int, secondPos: Int) {
        let firstValue = first.element(at: firstPos)
        first[first.index(at: firstPos)] = second.element(at: secondPos)
        second[second.index(at: secondPos)] = firstValue
    }
}

extension Array {
    public func index(at offset: Int) -> Index {
        return index(startIndex, offsetBy: offset)
    }
    
    public func element(at offset: Int) -> Element {
        return self[index(at: offset)]
    }
}
