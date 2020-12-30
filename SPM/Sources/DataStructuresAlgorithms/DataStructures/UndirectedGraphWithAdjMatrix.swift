//
//  UndirectedGraphWithAdjMatrix.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class WeightedUndirectedGraphWithAdjMatrix {
    public let vertices: [Vertice]
    public var adjMatrix: [[Int]]
    
    public init(vertices: [Vertice]) {
        self.vertices = vertices
        adjMatrix = [[Int]] (repeating: [Int] (repeating: Int.max, count: vertices.count), count: vertices.count)
    }
    
    open func addEdge(v1: Vertice, v2: Vertice, weight: Int) {
        adjMatrix[v1.id][v2.id] = weight
        adjMatrix[v2.id][v1.id] = weight
    }
    
    open func neighbours(v: Vertice) -> [Int] {
        return adjMatrix[v.id]
    }
}
