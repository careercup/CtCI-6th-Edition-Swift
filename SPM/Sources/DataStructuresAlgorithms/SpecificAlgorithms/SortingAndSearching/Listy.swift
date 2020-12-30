//
//  Listy.swift
//  
//
//  Created by Stefan Jaindl on 21.09.20.
//

import Foundation

open class Listy<T: Comparable> {
    private let array: [T]
    
    public init(array: [T]) {
        self.array = array.sorted()
    }
    
    open func element(at index: Int) -> T? {
        if index >= 0 && index < array.count {
            return array[index]
        }
        
        return nil
    }
}

open class ListySearcher<T: Comparable> {
    public init() { }
    
    open func listySearch(listy: Listy<T>, searched: T) -> Int? {
        guard listy.element(at: 0) != nil else {
            return nil
        }
        
        var currentIndex = 0
        var minValidIndex = 0
        var maxValidIndex = Int.max
        var valid = true
        
        while valid {
            let currentElement = listy.element(at: currentIndex)
            
            if currentElement == searched {
                return currentIndex
            } else if let currentElement = currentElement, currentElement < searched {
                minValidIndex = currentIndex //go right
                currentIndex = max(1, maxValidIndex == Int.max ? currentIndex * 2 : (currentIndex + maxValidIndex) / 2) //for index 0 increase to 1!
            } else { //currentElement > searched OR currentElement == nil
                maxValidIndex = currentIndex
                currentIndex = minValidIndex == 0 ? currentIndex / 2 : (currentIndex + minValidIndex) / 2
            }
            
            if abs(maxValidIndex - minValidIndex) <= 1 {
                valid = false
            }
        }
        
        return nil
    }
}
