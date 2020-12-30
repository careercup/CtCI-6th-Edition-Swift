//
//  FloydWarshall.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 11.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class FloydWarshallTests: XCTestCase {
    
    open func testFloydWarshall() throws {
        let graph = setupTestGraph()
        let floydWarshall = FloydWarshall(graph: graph)
        try floydWarshall.findShortestPaths()
        
        XCTAssertEqual(floydWarshall.graph.adjMatrix[0][0], 0)
        XCTAssertEqual(floydWarshall.graph.adjMatrix[0][3], 0)
        XCTAssertEqual(floydWarshall.graph.adjMatrix[1][3], 4)
        XCTAssertEqual(floydWarshall.graph.adjMatrix[2][3], 2)
    }
    
    //https://www.techiedelight.com/pairs-shortest-paths-floyd-warshall-algorithm/
    private func setupTestGraph() -> WeightedDirectedGraphWithAdjMatrix {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3)]
        let graph = WeightedDirectedGraphWithAdjMatrix(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[2], weight: -2)
        graph.addEdge(v1: vertices[1], v2: vertices[0], weight: 4)
        graph.addEdge(v1: vertices[1], v2: vertices[2], weight: 3)
        graph.addEdge(v1: vertices[2], v2: vertices[3], weight: 2)
        graph.addEdge(v1: vertices[3], v2: vertices[1], weight: -1)
        
        return graph
    }
}
