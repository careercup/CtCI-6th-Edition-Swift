//
//  MinimumSpanningTreePrim.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 13.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class MinimumSpanningTreePrim {
    
    public var graph: WeightedUndirectedGraph
    
    public init(graph: WeightedUndirectedGraph) {
        self.graph = graph
    }
    
    open func minimumSpanningTree() -> [Edge] {
        var mstEdges: [Edge] = []
        var mstVertices: Set<Vertice> = Set()
        let outsideVertices: IndexedMinPriorityQueue<Vertice> = IndexedMinPriorityQueue(maxElements: graph.vertices.count)
        
        for vertice in graph.vertices { // O(V)
            let weight = vertice.id == 0 ? 0 : Int.max
            vertice.weight = weight
            try! outsideVertices.insert(index: vertice.id, key: vertice)
        }
        
        while mstVertices.count < graph.vertices.count { // O(V)
            let minVertice = try! outsideVertices.extractMin()! //O(log V)
            mstVertices.insert(minVertice)
            
            if let edge = minVertice.minIngoingEdge {
                mstEdges.append(edge)
            }
            
            let neighbours = graph.neighbours(v: minVertice)
            var neighbour = neighbours.head
            
            while let curNeighbour = neighbour { //O(E/V)
                let edge = curNeighbour.val
                let otherVertice = minVertice == edge.from ? edge.to : edge.from
                if !mstVertices.contains(otherVertice) { //O(1)
                    if otherVertice.weight > edge.weight {
                        otherVertice.weight = edge.weight
                        otherVertice.minIngoingEdge = edge
                        try! outsideVertices.changeKey(index: otherVertice.id, key: otherVertice) //O(log V) with IndexPQ.
                    }
                }
                
                neighbour = neighbour?.next
            }
        }
        
        return mstEdges
    }
}
