//
//  UnionFind.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

public struct UnionFindElement {
    public var parent: Int
    public var size: Int
}

open class UnionFind {
    //union find with path compression and rank by size
    private var components: [UnionFindElement]
    private(set) var numberOfComponents: Int
    
    public init(numberOfElements: Int) {
        components = [UnionFindElement] (repeating: UnionFindElement(parent: -1, size: 0), count: numberOfElements)
        numberOfComponents = numberOfElements
    }
    
    public convenience init(graph: WeightedUndirectedGraph) {
        self.init(numberOfElements: graph.vertices.count)
        
        for vertice in graph.vertices {
            components[vertice.id] = UnionFindElement(parent: vertice.id, size: 1)
        }
    }
    
    open func find(index: Int) -> Int {
        if components[index].parent != index {
            //path compression
            components[index].parent = find(index: components[index].parent)
        }
        
        return components[index].parent
    }
    
    open func union(firstIndex: Int, secondIndex: Int) {
        let firstElement = find(index: firstIndex)
        let secondElement = find(index: secondIndex)
        
        if firstElement == secondElement {
            //cycle detected!
            //throw NSError(domain: "UnionFind - Cycle detected!", code: 0, userInfo: nil)
        } else {
            //weight by rank (size)
            if components[firstElement].size > components[secondElement].size {
                components[secondElement].parent = firstElement
            } else if components[firstElement].size < components[secondElement].size {
                components[firstElement].parent = secondElement
            } else {
                components[secondElement].parent = firstElement
                components[firstElement].size += 1
            }
            
            numberOfComponents -= 1
        }
    }
    
}
