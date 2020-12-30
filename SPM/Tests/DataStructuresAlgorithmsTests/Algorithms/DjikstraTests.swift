//
//  Djikstra.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 02.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import XCTest
@testable import DataStructuresAlgorithms

open class DjikstraTests: XCTestCase {
    
    open func testDjikstra() throws {
        let graph = setupTestGraph()
        let djikstra = Djikstra(graph: graph)
        let distance = try djikstra.djikstra(from: graph.vertices[0], to: graph.vertices[4])
        
        XCTAssertNotNil(distance)
        XCTAssertEqual(distance!, 21)
        
        let path = djikstra.path(to: graph.vertices[4])
        let pathIds = path.compactMap {
            return $0.id
        }
        
        XCTAssertEqual(pathIds, [0, 7, 6, 5, 4])
    }
    
    //https://www.geeksforgeeks.org/dijkstras-shortest-path-algorithm-greedy-algo-7/
    private func setupTestGraph() -> WeightedUndirectedGraph {
        let vertices: [Vertice] = [Vertice(id: 0), Vertice(id: 1), Vertice(id: 2),
                                    Vertice(id: 3), Vertice(id: 4), Vertice(id: 5),
                                    Vertice(id: 6), Vertice(id: 7), Vertice(id: 8)]
        let graph = WeightedUndirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1], weight: 4)
        graph.addEdge(v1: vertices[0], v2: vertices[7], weight: 8)
        graph.addEdge(v1: vertices[1], v2: vertices[2], weight: 8)
        graph.addEdge(v1: vertices[1], v2: vertices[7], weight: 11)
        graph.addEdge(v1: vertices[2], v2: vertices[3], weight: 7)
        graph.addEdge(v1: vertices[2], v2: vertices[5], weight: 4)
        graph.addEdge(v1: vertices[2], v2: vertices[8], weight: 2)
        graph.addEdge(v1: vertices[3], v2: vertices[4], weight: 9)
        graph.addEdge(v1: vertices[3], v2: vertices[5], weight: 14)
        graph.addEdge(v1: vertices[4], v2: vertices[5], weight: 10)
        graph.addEdge(v1: vertices[5], v2: vertices[6], weight: 2)
        graph.addEdge(v1: vertices[6], v2: vertices[7], weight: 1)
        graph.addEdge(v1: vertices[6], v2: vertices[8], weight: 6)
        graph.addEdge(v1: vertices[7], v2: vertices[8], weight: 7)
        
        return graph
    }
}
