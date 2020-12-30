//
//  WeightedDirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class WeightedDirectedGraph {
    public let vertices: [Vertice]
    private var adjList: [DoubleLinkedList<Edge>] = []
    
    public init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(DoubleLinkedList<Edge>())
        }
    }
    
    open func addEdge(v1: Vertice, v2: Vertice, weight: Int) {
        let edge = Edge(from: v1, to: v2, weight: weight)
        adjList[v1.id].add(node: Node(val: edge))
    }
    
    open func neighbours(v: Vertice) -> DoubleLinkedList<Edge> {
        return adjList[v.id]
    }
    
    open func edges() -> [Edge] {
        var edges: [Edge] = []
        for edgeList in adjList {
            var current = edgeList.head
            while let cur = current {
                edges.append(cur.val)
                current = cur.next
            }
        }
        
        return edges
    }
}
