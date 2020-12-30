//
//  WeightedDirectedGraphWithAjdMatrix.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 11.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class WeightedDirectedGraphWithAdjMatrix {
    public let vertices: [Vertice]
    public var adjMatrix: [[Int]]
    
    public init(vertices: [Vertice]) {
        self.vertices = vertices
        
        adjMatrix = Array(repeating: Array(repeating: Int.max, count: vertices.count), count: vertices.count)
        
        for index in 0 ... vertices.count - 1 {
            adjMatrix[index][index] = 0
        }
    }
    
    open func addEdge(v1: Vertice, v2: Vertice, weight: Int) {
        adjMatrix[v1.id][v2.id] = weight
    }
}
