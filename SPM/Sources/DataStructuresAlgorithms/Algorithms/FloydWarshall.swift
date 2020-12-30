//
//  FloydWarshall.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 11.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class FloydWarshall {
    public let graph: WeightedDirectedGraphWithAdjMatrix
    
    public init(graph: WeightedDirectedGraphWithAdjMatrix) {
        self.graph = graph
    }
    
    open func findShortestPaths() throws {
        for intermediateIndex in 0 ... graph.vertices.count - 1 {
            for startIndex in 0 ... graph.vertices.count - 1 {
                for endIndex in 0 ... graph.vertices.count - 1 {
                    if graph.adjMatrix[startIndex][intermediateIndex] < Int.max && graph.adjMatrix[intermediateIndex][endIndex] < Int.max
                        && graph.adjMatrix[startIndex][intermediateIndex] + graph.adjMatrix[intermediateIndex][endIndex] < graph.adjMatrix[startIndex][endIndex] {
                        graph.adjMatrix[startIndex][endIndex] = graph.adjMatrix[startIndex][intermediateIndex] + graph.adjMatrix[intermediateIndex][endIndex]
                    }
                }
            }
        }
        
        //Check for negative cycle:
        for index in 0 ... graph.vertices.count - 1 {
            if graph.adjMatrix[index][index] < 0 {
                throw NSError(domain: "FloydWarshall: Negative Cycle", code: 0, userInfo: nil)
            }
        }
    }
}
