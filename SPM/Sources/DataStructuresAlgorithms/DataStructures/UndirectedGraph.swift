//
//  UndirectedGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class UndirectedGraph {
    public let vertices: [Vertice]
    private var adjList: [DoubleLinkedList<Vertice>] = []
    
    public init(vertices: [Vertice]) {
        self.vertices = vertices
        
        for _ in vertices {
            adjList.append(DoubleLinkedList<Vertice>())
        }
    }
    
    open func addEdge(v1: Vertice, v2: Vertice) {
        adjList[v1.id].add(node: Node(val: v2))
        adjList[v2.id].add(node: Node(val: v1))
    }
    
    open func neighbours(v: Vertice) -> DoubleLinkedList<Vertice> {
        return adjList[v.id]
    }
}
