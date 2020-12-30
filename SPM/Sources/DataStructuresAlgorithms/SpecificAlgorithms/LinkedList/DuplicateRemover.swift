//
//  DuplicateRemover.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 01.06.20.
//

import Foundation

open class DuplicateRemover<T: Comparable> {
    
    public init() { }
    
    open func removeDuplicates(linkedList: SingleLinkedList<T>) {
        let root = linkedList.head
        var current: SingleNode? = root
        
        while let outerNode = current {
            let currentValue = outerNode.val
            var previous: SingleNode? = outerNode
            var currentInnerNode = current?.next
            
            while currentInnerNode != nil {
                if let innerNodeValue = currentInnerNode?.val, innerNodeValue == currentValue {
                    previous?.next = currentInnerNode?.next
                    currentInnerNode = currentInnerNode?.next
                    linkedList.count -= 1
                } else {
                    previous = previous?.next
                    currentInnerNode = currentInnerNode?.next
                }
            }
            
            current = current?.next
        }
    }
}
