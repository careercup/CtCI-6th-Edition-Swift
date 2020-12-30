//
//  DuplicateRemover.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 01.06.20.
//

import Foundation

open class SumLists {
    
    public init() { }
    
    open func reverseSum(first: SingleNode<Int>?, second: SingleNode<Int>?, carry: Int = 0) -> SingleNode<Int>? {
        if first == nil, second == nil {
            if carry == 1 {
                return SingleNode<Int>(val: carry)
            }
            return nil
        }
        
        var sum = carry
        if let firstVal = first?.val {
            sum += firstVal
        }
        
        if let secondVal = second?.val {
            sum += secondVal
        }
        
        let node = SingleNode<Int>(val: sum % 10)
        node.next = reverseSum(first: first?.next, second: second?.next, carry: sum > 9 ? 1 : 0)
        
        return node
    }
    
    open func sumNodes(first: SingleNode<Int>, second: SingleNode<Int>, carry: Int = 0) -> SingleLinkedList<Int> {
        let firstNodeCount = len(first)
        let secondNodeCount = len(second)
        
        if firstNodeCount < secondNodeCount {
            pad(first, with: 0, forCount: secondNodeCount - firstNodeCount)
        } else if secondNodeCount < firstNodeCount {
            pad(second, with: 0, forCount: firstNodeCount - secondNodeCount)
        }
        
        let result = sum(first: first, second: second)
        if result.carry == 1 {
            result.resultList.prepend(node: SingleNode<Int>(val: result.carry))
        }
        
        return result.resultList
    }
    
    private func len(_ node: SingleNode<Int>) -> Int {
        var count = 0
        var current: SingleNode<Int>? = node
        while current != nil {
            count += 1
            current = current?.next
        }
        
        return count
    }
    
    private func pad(_ node: SingleNode<Int>, with: Int, forCount: Int) {
        var currentNode = node
        for _ in 0 ..< forCount {
            let newNode = SingleNode<Int>(val: with)
            newNode.next = currentNode
            currentNode = newNode
        }
    }
    
    private func sum(first: SingleNode<Int>?, second: SingleNode<Int>?) -> ResultWrapper {
        guard let first = first, let second = second else {
            return ResultWrapper(carry: 0, resultList: SingleLinkedList<Int>())
        }
        
        var wrapper = sum(first: first.next, second: second.next)
        let sumAtNode = first.val + second.val + wrapper.carry
        let sumNode = SingleNode<Int>(val: sumAtNode % 10)
        
        wrapper.resultList.prepend(node: sumNode)
        wrapper.carry = sumAtNode > 9 ? 1 : 0
        
        return wrapper
    }
}

private struct ResultWrapper {
    var carry: Int
    var resultList: SingleLinkedList<Int>
}
