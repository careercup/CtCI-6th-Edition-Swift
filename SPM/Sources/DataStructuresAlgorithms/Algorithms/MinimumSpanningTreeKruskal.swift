//
//  MinimumSpanningTreeKruskal.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 12.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class MinimumSpanningTreeKruskal {
    //1. Sort edges by weight --> O(E log E)
        //alternative use priority queue --> O(E log E)
    //2. Pop min edge
    //3. If there is a cycle, discard (detection with UnionFind)
    //4. Else include in MST
    
    public var graph: WeightedUndirectedGraph
    
    public init(graph: WeightedUndirectedGraph) {
        self.graph = graph
    }
    
    open func minimumSpanningTreeQuickSort() -> [Edge] {
        var mst: [Edge] = []
        var edges = graph.edges()
        
        //test
        let pq1 = MinHeap<Int>()
        for edge in edges {
            pq1.insert(val: edge.weight)
        }
        
        QuickSort.quickSort(array: &edges) // O(E log E)
        
        let components = UnionFind(graph: graph)
        
        var index = 0
        while mst.count < graph.vertices.count - 1 {
            let edge = edges[index]
            let firstVertice = edges[index].from
            let secondVertice = edges[index].to
            
            let parentOfFirstVertice = components.find(index: firstVertice.id)
            let parentOfSecondVertice = components.find(index: secondVertice.id)
            
            if parentOfFirstVertice != parentOfSecondVertice {
                //no cylce, if we take this edge
                mst.append(edge)
                components.union(firstIndex: parentOfFirstVertice, secondIndex: parentOfSecondVertice)
            } // else we have a cycle: ignore edge
            
            index += 1
        }
        
        return mst
    }
    
    open func minimumSpanningTreeHeap() -> [Edge] {
        var mst: [Edge] = []
        let edges = graph.edges()
        
        //test
        let pq1 = MinHeap<Int>()
        for edge in edges {
            pq1.insert(val: edge.weight)
        }
        
        let pq = MinHeap<Edge>()
        for edge in edges { //O(E log E)
            pq.insert(val: edge)
        }
        
        let components = UnionFind(graph: graph)
        
        var index = 0
        while mst.count < graph.vertices.count - 1 {
            
            let edge = try! pq.extractMin()
            let firstVertice = edge.from
            let secondVertice = edge.to
            
            let parentOfFirstVertice = components.find(index: firstVertice.id)
            let parentOfSecondVertice = components.find(index: secondVertice.id)
            
            if parentOfFirstVertice != parentOfSecondVertice {
                //no cylce, if we take this edge
                mst.append(edge)
                components.union(firstIndex: parentOfFirstVertice, secondIndex: parentOfSecondVertice)
            } // else we have a cycle: ignore edge
            
            index += 1
        }
        
        return mst
    }
}
