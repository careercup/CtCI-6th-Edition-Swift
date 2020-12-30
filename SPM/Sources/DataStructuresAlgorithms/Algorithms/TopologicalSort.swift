//
//  TopologicalSort.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class TopologicalSort {
    private var graph: DirectedGraph
    
    public init(graph: DirectedGraph) {
        self.graph = graph
    }
    
    open func topologicalSort() throws -> Queue<Vertice> {
        let sort = Queue<Vertice>()
        let processNext = Queue<Vertice>()
        
        for vertice in graph.vertices {
            let neighbours = graph.neighbours(v: vertice)
            var currentNeighbour = neighbours.head
            while let current = currentNeighbour {
                current.val.inboundCount += 1
                currentNeighbour = current.next
            }
        }
        
        for vertice in graph.vertices {
            if vertice.inboundCount == 0 {
                processNext.enqueue(val: vertice)
            }
        }
        
        while !processNext.isEmpty(), let vertice = try? processNext.dequeue() {
            sort.enqueue(val: vertice)
            let neighbours = graph.neighbours(v: vertice)
            var currentNeighbour = neighbours.head
            while let current = currentNeighbour {
                current.val.inboundCount -= 1
                if current.val.inboundCount == 0 {
                    processNext.enqueue(val: current.val)
                }
                
                currentNeighbour = current.next
            }
        }
        
        if sort.size != graph.vertices.count {
            throw NSError(domain: "topologicalSort: There is a cycle in the graph", code: 0, userInfo: nil)
        }
        
        return sort
    }
}
