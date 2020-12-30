//
//  BipartiteGraph.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 23.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class BipartiteGraphCheckerTests: XCTestCase {
    
    open func testBipartiteGraph() {
        let graph = setupTestGraph()
        let bipartite = BipartiteGraphChecker(graph: graph)
        let colors = try? bipartite.isBipartite()
        
        XCTAssertNotNil(colors)
        for (index, color) in colors!.enumerated() {
            if index % 2 == 0 {
                XCTAssertEqual(color, .red)
            } else {
                XCTAssertEqual(color, .black)
            }
        }
    }
    
    //https://www.geeksforgeeks.org/bipartite-graph
    private func setupTestGraph() -> UndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2), Vertice(id: 3),
                                   Vertice(id: 4), Vertice(id: 5), Vertice(id: 6), Vertice(id: 7),
                                   Vertice(id: 8), Vertice(id: 9), Vertice(id: 10), Vertice(id: 11)]
        let graph = UndirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1])
        graph.addEdge(v1: vertices[1], v2: vertices[2])
        graph.addEdge(v1: vertices[2], v2: vertices[3])
        graph.addEdge(v1: vertices[3], v2: vertices[4])
        graph.addEdge(v1: vertices[4], v2: vertices[5])
        graph.addEdge(v1: vertices[5], v2: vertices[0])
        
        //2 connected components
        graph.addEdge(v1: vertices[6], v2: vertices[7])
        graph.addEdge(v1: vertices[7], v2: vertices[8])
        graph.addEdge(v1: vertices[8], v2: vertices[9])
        graph.addEdge(v1: vertices[9], v2: vertices[10])
        graph.addEdge(v1: vertices[10], v2: vertices[11])
        graph.addEdge(v1: vertices[11], v2: vertices[6])
        
        return graph
    }
}
