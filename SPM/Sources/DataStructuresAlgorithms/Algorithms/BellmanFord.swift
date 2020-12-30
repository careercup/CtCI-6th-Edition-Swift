//
//  BellmanFord.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 09.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class BellmanFord {
    public let graph: WeightedDirectedGraph
    
    public init(graph: WeightedDirectedGraph) {
        self.graph = graph
    }
    
    open func findShortestPath(source: Vertice, target: Vertice) throws -> Int {
        var distTo = [Int] (repeating: Int.max, count: graph.vertices.count)
        distTo[source.id] = 0
        
        var pass = 1
        
        while pass < graph.vertices.count {
            for edge in graph.edges() {
                if distTo[edge.from.id] != Int.max && distTo[edge.to.id] > distTo[edge.from.id] + edge.weight {
                    distTo[edge.to.id] = distTo[edge.from.id] + edge.weight
                }
            }
            pass += 1
        }
        
        //Check for negative cycle: There is one, if edges can be forever relaxed.
        for edge in graph.edges() {
            if distTo[edge.from.id] != Int.max && distTo[edge.to.id] > distTo[edge.from.id] + edge.weight {
                throw NSError(domain: "Bellman Ford: Negative Cycle", code: 0, userInfo: nil)
            }
        }
        
        return distTo[target.id]
    }
}
