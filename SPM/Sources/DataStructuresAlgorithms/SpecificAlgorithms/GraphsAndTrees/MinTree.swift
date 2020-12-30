//
//  MinTree.swift
//  
//
//  Created by Stefan Jaindl on 23.06.20.
//

import Foundation

open class MinTree<T: Comparable> {
    
    //Given: Ascendingly sorted array without duplicates
    //Return: Root of build binary search tree
    open func minTree(array: [T]) throws -> SimpleTreeNode<T> {
        guard array.count > 0 else {
            throw NSError(domain: "MinTree: Empty input", code: 0, userInfo: nil)
        }
        
        let minIndex = 0
        let maxIndex = array.count - 1
        let middleIndex = minIndex + (maxIndex - minIndex) / 2
        let root = SimpleTreeNode(value: array[middleIndex])
        
        root.left = insert(array: array, minIndex: 0, maxIndex: middleIndex - 1, root: root)
        root.right = insert(array: array, minIndex: middleIndex + 1, maxIndex: maxIndex, root: root)
        
        return root
    }
    
    private func insert(array: [T], minIndex: Int, maxIndex: Int, root: SimpleTreeNode<T>) -> SimpleTreeNode<T>? {
        if minIndex > maxIndex {
            return nil
        }
        
        let middleIndex = minIndex + (maxIndex - minIndex) / 2
        let node = SimpleTreeNode(value: array[middleIndex])
        
        node.left = insert(array: array, minIndex: minIndex, maxIndex: middleIndex - 1, root: node)
        node.right = insert(array: array, minIndex: middleIndex + 1, maxIndex: maxIndex, root: node)
        
        return node
    }
}
