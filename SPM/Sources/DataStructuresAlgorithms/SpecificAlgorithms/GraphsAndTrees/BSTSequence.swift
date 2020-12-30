//
//  BSTSequence.swift
//  
//
//  Created by Stefan Jaindl on 06.07.20.
//

import Foundation

open class BSTSequence<T: Comparable> {
    
    public init() { }
    
    //Returns all possible arrays from which the given BST could result (no self-balancing tree)
    open func BSTSequences(root: SimpleTreeNode<T>?) -> [[SimpleTreeNode<T>]] {
        guard let root = root else {
            return []
        }
        
        let leftSequences = BSTSequences(root: root.left)
        let rightSequences = BSTSequences(root: root.right)
        
        if leftSequences.isEmpty, rightSequences.isEmpty {
            return [[root]]
        } else if leftSequences.isEmpty {
            return rightSequences
        } else if rightSequences.isEmpty {
            return leftSequences
        }
        
        var sequences: [[SimpleTreeNode<T>]] = []
        
        leftSequences.forEach { left in
            rightSequences.forEach { right in
                sequences.append(contentsOf: weave(left: left, right: right, prefix: [root]))
            }
        }
        
        return sequences
    }
    
    private func weave(left: [SimpleTreeNode<T>], right: [SimpleTreeNode<T>], prefix: [SimpleTreeNode<T>]) -> [[SimpleTreeNode<T>]] {
        var newPrefix = prefix
        
        if left.isEmpty {
            newPrefix.append(contentsOf: right)
            return [newPrefix]
        } else if right.isEmpty {
            newPrefix.append(contentsOf: left)
            return [newPrefix]
        }
        
        newPrefix.append(left[0])
        var result = weave(left: Array(left[1..<left.count]), right: right, prefix: newPrefix)
        
        newPrefix = prefix
        newPrefix.append(right[0])
        let rightFirstWeaves = weave(left: left, right: Array(right[1..<right.count]), prefix: newPrefix)
        
        result.append(contentsOf: rightFirstWeaves)
        
        return result
    }
}
