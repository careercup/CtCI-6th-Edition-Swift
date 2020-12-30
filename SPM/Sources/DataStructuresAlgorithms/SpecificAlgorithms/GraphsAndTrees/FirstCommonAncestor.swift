//
//  FirstCommonAncestor.swift
//  
//
//  Created by Stefan Jaindl on 30.06.20.
//

import Foundation

open class FirstCommonAncestor<T: Comparable> {
    
    public init() { }
    
    //Return the first common ancestor of two nodes (without parent links)
    open func firstCommonAncestor(root: SimpleTreeNode<T>, first: SimpleTreeNode<T>, second: SimpleTreeNode<T>) -> SimpleTreeNode<T>? {
        var parent: SimpleTreeNode<T>? = root
        var isValidRoot = true
        
        if first === second {
            return first
        }
        
        while isValidRoot {
            let firstLeftFound = isDescendant(root: parent?.left, node: first)
            let secondLeftFound = isDescendant(root: parent?.left, node: second)
            
            //If both nodes are on the left side, move to left child
            if firstLeftFound && secondLeftFound {
                parent = parent?.left
                continue
            }
            
            let firstRightFound = isDescendant(root: parent?.right, node: first)
            let secondRightFound = isDescendant(root: parent?.right, node: second)
            
            //If both nodes are on the right side, move to right child
            if firstRightFound && secondRightFound {
                parent = parent?.right
                continue
            }
            
            //If both nodes are found on different sides, parent is the FCA
            if (firstLeftFound || firstRightFound || first === parent) && (secondLeftFound || secondRightFound || second === parent) {
                return parent
            }
            
            //If no node was found, input is an invalid node
            isValidRoot = false
        }
        
        return nil
    }
    
    private func isDescendant(root: SimpleTreeNode<T>?, node: SimpleTreeNode<T>) -> Bool {
        guard let root = root else {
            return false
        }
        
        if root === node {
            return true
        }
        
        return isDescendant(root: root.left, node: node) || isDescendant(root: root.right, node: node)
    }
}
