//
//  RandomBinarySearchTree.swift
//  
//
//  Created by Stefan Jaindl on 12.07.20.
//

import Foundation

open class RandomBinarySearchTree<T: Comparable> {
    
    var root: SimpleTreeNode<T>?
    
    public init() { }
    
    open func insert(value: T) {
        if root == nil {
            root = SimpleTreeNode<T>(value: value, numElements: 1)
        } else {
            var currentNode = root
            while let current = currentNode {
                current.numElements += 1
                
                if value <= current.value {
                    if current.left == nil {
                        current.left = SimpleTreeNode<T>(value: value, numElements: 1)
                        return
                    } else {
                        currentNode = current.left
                    }
                } else {
                    if current.right == nil {
                        current.right = SimpleTreeNode<T>(value: value, numElements: 1)
                        return
                    } else {
                        currentNode = current.right
                    }
                }
            }
        }
    }
    
    open func find(value: T) -> SimpleTreeNode<T>? {
        var current = root
        
        while let currentNode = current {
            if currentNode.value == value {
                return currentNode
            }
            
            current = currentNode.value > value ? currentNode.left : currentNode.right
        }
        
        return nil
    }
    
    //TODO: Check delete functionality for root
    open func delete(value: T) {
        var current = root
        var previous: SimpleTreeNode<T>? = nil
        
        while let currentNode = current {
            if currentNode.value == value {
                break
            }
            
            previous = current
            previous?.numElements -= 1
            current = currentNode.value > value ? currentNode.left : currentNode.right
        }
        
        //case 1: node has no childs - simply delete
        if current?.left == nil, current?.right == nil {
            if previous?.left === current {
                previous?.left = nil
            } else {
                previous?.right = nil
            }
        }
        
        //case 2: node has 1 child: upgrade
        else if current?.left == nil {
            if previous?.left === current {
                previous?.left = current?.right
            } else {
                previous?.right = current?.right
            }
            previous?.numElements -= 1
        } else if current?.right == nil {
            if previous?.left === current {
                previous?.left = current?.left
            } else {
                previous?.right = current?.left
            }
        }
        
        //case 3: node has 2 childs - exchange with inorder successor (or predecessor)
        else {
            if let left = current?.left, let right = current?.right, left.numElements > right.numElements {
                let (previousPredecessor, predecessorNode) = inorderPredecessor(root: current)
                //Remove last node
                if previousPredecessor?.left === predecessorNode {
                    previousPredecessor?.left = nil
                } else {
                    previousPredecessor?.right = nil
                }
                
                //replace node with in-order predecessor
                if previous?.left === current {
                    previous?.left = predecessorNode
                } else {
                    previous?.right = predecessorNode
                }
                
                if previousPredecessor === root {
                    root = predecessorNode
                }
            } else {
                let (previousSuccessor, successorNode) = inorderSuccessor(root: current)
                //Remove last node
                if previousSuccessor?.left === successorNode {
                    previousSuccessor?.left = nil
                } else {
                    previousSuccessor?.right = nil
                }
                
                //replace node with in-order predecessor
                if previous?.left === current {
                    previous?.left = successorNode
                } else {
                    previous?.right = successorNode
                }
                
                if previousSuccessor === root {
                    root = successorNode
                }
            }
        }
        
        if current === root, current?.numElements == 0 {
            root = nil
            return
        }
    }
    
    open func getRandomNode() -> SimpleTreeNode<T>? {
        guard let root = root else {
            return nil
        }
        
        var random = Int.random(in: 0..<root.numElements)
        var currentNode: SimpleTreeNode<T>? = root
        
        while let current = currentNode {
            
            var rootId = 0
            if let left = current.left {
                rootId += left.numElements
            }
            
            if random == rootId {
                return currentNode
            } else if random < rootId {
                currentNode = current.left
            } else {
                random -= rootId + 1
                currentNode = current.right
            }
        }
        
        return currentNode
    }
    
    private func inorderSuccessor(root: SimpleTreeNode<T>?) -> (SimpleTreeNode<T>?, SimpleTreeNode<T>?) {
        var node = root?.right
        var previous: SimpleTreeNode<T>? = root
        
        if let left = node?.left, let right = node?.right, left.numElements > right.numElements {
            node?.numElements -= 1
        }
        
        while let leftNode = node?.left {
            if let left = leftNode.left, let right = leftNode.right, left.numElements < right.numElements {
                leftNode.numElements -= 1
            }
            
            previous = node
            node = leftNode
        }
        
        return (previous, node)
    }
    
    private func inorderPredecessor(root: SimpleTreeNode<T>?) -> (SimpleTreeNode<T>?, SimpleTreeNode<T>?) {
        var node = root?.left
        var previous: SimpleTreeNode<T>? = root
        
        if let left = node?.left, let right = node?.right, left.numElements < right.numElements {
            node?.numElements -= 1
        }
        
        while let rightNode = node?.right {
            if let left = rightNode.left, let right = rightNode.right, left.numElements > right.numElements {
                rightNode.numElements -= 1
            }
            
            previous = node
            node = rightNode
        }
        
        return (previous, node)
    }
}
