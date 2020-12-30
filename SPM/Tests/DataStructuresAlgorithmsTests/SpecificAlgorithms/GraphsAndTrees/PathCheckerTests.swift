//
//  PathCheckerTests.swift
//  
//
//  Created by Stefan Jaindl on 22.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class PathCheckerTests: XCTestCase {
    
    open func testPathChecker() {
        let from = Vertice(id: 0)
        let to = Vertice(id: 3)
        let unconnected = Vertice(id: 6)
        let graph = setupTestGraph(from: from, to: to, unconnected: unconnected)
        
        XCTAssertTrue(graph.pathExists(from: from, to: to))
        XCTAssertFalse(graph.pathExists(from: from, to: unconnected))
    }
    
    private func setupTestGraph(from: Vertice, to: Vertice, unconnected: Vertice) -> DirectedGraph {
        let vertices: [Vertice] = [from, Vertice(id: 1), Vertice(id: 2),
                                    to, Vertice(id: 4), Vertice(id: 5), unconnected]
        let graph = DirectedGraph(vertices: vertices)
        
        graph.addEdge(v1: vertices[0], v2: vertices[1])
        graph.addEdge(v1: vertices[0], v2: vertices[2])
        graph.addEdge(v1: vertices[1], v2: vertices[2])
        graph.addEdge(v1: vertices[1], v2: vertices[3])
        graph.addEdge(v1: vertices[2], v2: vertices[1])
        graph.addEdge(v1: vertices[2], v2: vertices[4])
        graph.addEdge(v1: vertices[4], v2: vertices[5])
        graph.addEdge(v1: vertices[5], v2: vertices[3])
        
        return graph
    }
}
