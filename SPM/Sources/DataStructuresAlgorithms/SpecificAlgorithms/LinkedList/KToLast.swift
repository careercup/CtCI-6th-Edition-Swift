//
//  KToLast.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 03.06.20.
//

import Foundation

open class KToLast<T: Comparable> {
    
    public init() { }
    
    open func kToLast(linkedList: SingleLinkedList<T>, k: Int) -> SingleNode<T>? {
        guard k >= 0 else {
            return nil
        }
        
        var front = linkedList.head
        for _ in 0 ..< k {
            if front?.next == nil {
                return nil
            } else {
                front = front?.next
            }
        }
        
        var back = linkedList.head
        while front?.next != nil {
            front = front?.next
            back = back?.next
        }
        
        return back
    }
}
