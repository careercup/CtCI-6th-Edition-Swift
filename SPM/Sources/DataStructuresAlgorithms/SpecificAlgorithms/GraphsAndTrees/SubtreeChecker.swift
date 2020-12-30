//
//  SubTreeChecker.swift
//  
//
//  Created by Stefan Jaindl on 12.07.20.
//

import Foundation

open class SubTreeChecker<T: Comparable> {
    
    private let nilNodeValue: T
    
    public init(nilNodeValue: T) {
        self.nilNodeValue = nilNodeValue
    }
    
    //Given: Checks whether subtree is really a subtree of tree
    //This can be checked by whether it is an array subsequence with preorder traversal and nil node values at leave nodes
    open func isSubtree(tree: SimpleTreeNode<T>, subtree: SimpleTreeNode<T>) -> Bool {
        let subPreorder = preorderTravelsal(root: subtree)
        let treePreorder = preorderTravelsal(root: tree)
        
        let subTreeValues = subPreorder.compactMap { return $0.value }
        let treeValues = treePreorder.compactMap { return $0.value }
        
        return treeValues.contains(subarray: subTreeValues)
    }
    
    private func preorderTravelsal(root: SimpleTreeNode<T>) -> [SimpleTreeNode<T>] {
        var preorder = [root]
        
        if root.left == nil, root.right == nil {
            preorder.append(SimpleTreeNode<T>(value: nilNodeValue))
        }
        
        if let left = root.left {
            preorder.append(contentsOf: preorderTravelsal(root: left))
        }
        
        if let right = root.right {
            preorder.append(contentsOf: preorderTravelsal(root: right))
        }
        
        return preorder
    }
}

extension Array where Element: Comparable {
    func contains(subarray: [Element]) -> Bool {
        var found = 0
        for element in self where found < subarray.count {
            if element == subarray[found] {
                found += 1
            } else {
                found = element == subarray[0] ? 1 : 0
            }
        }
        
        return found == subarray.count
    }
}
