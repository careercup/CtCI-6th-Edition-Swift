//
//  DeleteMiddleNode.swift
//  DataStructuresAlgorithms
//
//  Created by Stefan Jaindl on 03.06.20.
//

import Foundation

open class DeleteMiddleNode<T: Comparable> {
    
    public init() { }
    
    open func deleteNode(node: SingleNode<T>) {
        guard let nextNode = node.next else {
            //In case the node is the last node, deletion isn't possible.
            //It could be marked as dummy, though.
            return
        }
        
        node.val = nextNode.val
        node.next = nextNode.next
    }
}
