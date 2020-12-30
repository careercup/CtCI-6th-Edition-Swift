//
//  BipartiteGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class BipartiteGraphChecker {
    
    public enum Color {
        case red
        case black
        case none
    }
    
    public var graph: UndirectedGraph
    
    public init(graph: UndirectedGraph) {
        self.graph = graph
    }
    
    open func isBipartite() throws -> [Color]? {
        if graph.vertices.count < 1 {
            return []
            //a graph with no edges is also Bipiartite. Note that the Bipartite condition says all edges should be from one set to another.
        }
        
        var colors: [Color]? = [Color] (repeating: .none, count: graph.vertices.count)
        
        for vertice in graph.vertices { //important if graph is not connected
            if colors?[vertice.id] == BipartiteGraphChecker.Color.none {
                colors = try isBipartite(vertice: vertice, colors: colors)
            }
        }
        
        return colors
    }
    
    open func isBipartite(vertice: Vertice, colors: [Color]?) throws -> [Color]? {
        guard var colors = colors else {
            return nil
        }
        
        let bfsQueue = Queue<Vertice>()
        let rootNode = graph.vertices[vertice.id]
        
        colors[rootNode.id] = .red
        bfsQueue.enqueue(val: rootNode)
        
        while !bfsQueue.isEmpty() {
            let curNode = try bfsQueue.dequeue()
            
            let neighbours = graph.neighbours(v: curNode)
            var currentHead = neighbours.head
            let colorForNeighbors: Color = colors[curNode.id] == .black ? .red : .black
            while let curHead = currentHead {
                let curVertice = curHead.val
                if colors[curVertice.id] == colors[curNode.id] {
                    return nil //same color between neighbors (not possible cycle)!
                }
                
                if curVertice.id == curNode.id {
                    return nil //graph is not bipartite, if there's a self-loop
                }
                
                if colors[curVertice.id] == .none {
                    colors[curVertice.id] = colorForNeighbors
                    bfsQueue.enqueue(val: curVertice)
                }
                
                currentHead = currentHead?.next
            }
        }
        
        return colors
    }
}
