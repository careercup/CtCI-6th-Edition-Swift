//
//  DeleteMiddleNode.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 03.06.20.
//

import Foundation

open class LinkedListPalindrome<T: Comparable> {
    
    public init() { }
    
    open func isPalindrome(linkedList: SingleLinkedList<T>) -> Bool {
        guard let head = linkedList.head, linkedList.count > 1 else {
            return true
        }
        
        return isPalindrome(node: head, index: 0, count: linkedList.count).isPalindrome
    }
    
    private func isPalindrome(node: SingleNode<T>?, index: Int, count: Int) -> ResultWrapper<T> {
        if index >= Int(trunc(Double(count) / 2)) {
            let node = count % 2 == 0 /* even */ ? node : /* odd */ node?.next
            return ResultWrapper(node: node, isPalindrome: true)
        }
        
        var resultSoFar = isPalindrome(node: node?.next, index: index + 1, count: count)
        let equal = resultSoFar.node?.val == node?.val
        resultSoFar.isPalindrome = resultSoFar.isPalindrome && equal
        resultSoFar.node = resultSoFar.node?.next
        
        return resultSoFar
    }
    
    private struct ResultWrapper<T: Comparable> {
        var node: SingleNode<T>?
        var isPalindrome: Bool
    }
}
