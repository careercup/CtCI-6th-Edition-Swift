//
//  LoopDetector.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 10.06.20.
//

import Foundation

open class LoopDetector<T: Comparable> {
    
    public init() { }
    
    open func detectLoop(linkedList: SingleLinkedList<T>) -> SingleNode<T>? {
        if linkedList.isEmpty() {
            return nil
        }
        
        guard let loopIndex = loop(linkedList: linkedList) else {
            return nil
        }
        
        let loopStartIndex = linkedList.count - loopIndex + 1
        //alternative: Reset slow runner to head and continue until slowRunner === fastRunner
        
        return node(linkedList: linkedList, offset: loopStartIndex)
    }
    
    func loop(linkedList: SingleLinkedList<T>) -> Int? {
        var slowRunner = linkedList.head
        var fastRunner = linkedList.head
        var count = 1
        
        while slowRunner?.val != fastRunner?.val {
            count += 1
            slowRunner = slowRunner?.next
            fastRunner = fastRunner?.next?.next
            
            if fastRunner == nil {
                return nil
            }
        }
        
        return count
    }
    
    func node(linkedList: SingleLinkedList<T>, offset: Int) -> SingleNode<T>? {
        var node = linkedList.head
        var index = 0
        while index < offset, node != nil {
            node = node?.next
            index += 1
        }
        
        return node
    }
}
