//
//  GraphSearch.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 27.03.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class GraphSearchTests: XCTestCase {
    
    open func testBFS() {
        let graph = setupTestGraph()
        
        let gsBfs = GraphSearch(graph: graph, start: graph.vertices[0])
        gsBfs.bfs()
    }
    
    open func testDFS() {
        let graph = setupTestGraph()
        
        let gsDfs = GraphSearch(graph: graph, start: graph.vertices[0])
        gsDfs.dfs()
    }
    
    open func testDFSIterative() {
        let graph = setupTestGraph()
        
        let gsDfsIt = GraphSearch(graph: graph, start: graph.vertices[0])
        gsDfsIt.dfs()
    }
    
    private func setupTestGraph() -> UndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4), Vertice(id: 5),
                                    Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let graph = UndirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1])
        graph.addEdge(v1: vertices[0], v2: vertices[2])
        graph.addEdge(v1: vertices[0], v2: vertices[3])
        
        graph.addEdge(v1: vertices[1], v2: vertices[2])
        graph.addEdge(v1: vertices[1], v2: vertices[4])
        graph.addEdge(v1: vertices[2], v2: vertices[5])
        graph.addEdge(v1: vertices[3], v2: vertices[8])
        graph.addEdge(v1: vertices[4], v2: vertices[5])
        graph.addEdge(v1: vertices[5], v2: vertices[6])
        graph.addEdge(v1: vertices[6], v2: vertices[7])
        graph.addEdge(v1: vertices[7], v2: vertices[8])
        graph.addEdge(v1: vertices[8], v2: vertices[6])
        
        return graph
    }
}
