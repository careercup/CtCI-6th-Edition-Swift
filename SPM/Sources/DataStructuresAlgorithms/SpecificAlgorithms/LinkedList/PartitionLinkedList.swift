//
//  DuplicateRemover.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 01.06.20.
//

import Foundation

open class PartitionLinkedList<T: Comparable> {
    
    public init() { }
    
    open func partition(linkedList: SingleLinkedList<T>, around pivot: T) {
        var prev: SingleNode<T>?
        var cur = linkedList.head
        var isHead = true
        while let current = cur {
            if current.val < pivot, !isHead {
                prev?.next = current.next
                current.next = linkedList.head
                linkedList.head = current
                cur = prev?.next
            } else {
                prev = prev != nil ? prev?.next : linkedList.head
                cur = cur?.next
            }
            
            isHead = false
        }
    }
}
