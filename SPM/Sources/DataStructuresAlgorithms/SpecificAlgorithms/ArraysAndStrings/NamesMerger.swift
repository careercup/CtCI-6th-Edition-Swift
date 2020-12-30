//
//  NamesMerger.swift
//  
//
//  Created by Stefan Jaindl on 06.12.20.
//

import Foundation

open class NamesMerger {
    public init() { }
    
    private var vertices: [Vertice] = []
    private var nameToMergedIndexDict: [String:Int] = [:]
    private var nameToVerticeIndexDict: [String:Int] = [:]
    
    open func mergeLists(nameFrequencies: [NameFrequency], nameMappings: [(String, String)]) throws -> [NameFrequency] {
        var mergedFrequency: [NameFrequency] = []
        
        // 1: Convert nameMappings array to directed graph
        /*
         E.g. nameMappings = [(Jon, John), (John, Johnny), (Chris, Kris), (Chris, Christopher)]
            --> mappingsGraph components = (Jon, John, Johnny), (Chris, Kris, Christopher)
         */
        
        let mappingGraph = buildNameMappingGraph(nameFrequencies: nameFrequencies, nameMappings: nameMappings)
        
        // 2: Associate already found indices for names
        /*
         E.g. nameFrequencies = [John: 15, Jon: 12, Chris: 13, Kris: 4, Christopher: 19]
         Check entries in connected graph components:
            --> no entry in index dict: Append to mergedFrequency and store index in nameToIndexDict
            --> entry in index dict: Sum up in mergedFrequency at index, store index in nameToIndexDict
         */
        
        try nameFrequencies.forEach { nameFrequency in
            let connectedComponents = try connectedNames(graph: mappingGraph, for: nameFrequency.name)
            
            if let index = findIndex(mapping: connectedComponents, nameToIndexDict: nameToMergedIndexDict) {
                let frequency = mergedFrequency[index]
                frequency.frequency += nameFrequency.frequency
                nameToMergedIndexDict[nameFrequency.name] = index
            } else {
                mergedFrequency.append(nameFrequency)
                nameToMergedIndexDict[nameFrequency.name] = mergedFrequency.count - 1
            }
        }
    
        return mergedFrequency
    }
    
    private func findIndex(mapping: Set<String>, nameToIndexDict: [String: Int]) -> Int? {
        var index: Int?

        mapping.forEach { name in
            if let nameIndex = nameToIndexDict[name] {
                index = nameIndex
                return
            }
        }

        return index
    }
    
    private func buildNameMappingGraph(nameFrequencies: [NameFrequency], nameMappings: [(String, String)]) -> UndirectedGraph {
        for (index, nameFrequency) in nameFrequencies.enumerated() {
            nameToVerticeIndexDict[nameFrequency.name] = index
            vertices.append(Vertice(id: index, name: nameFrequency.name))
        }
        
        nameMappings.forEach { mapping in
            if vertice(for: mapping.0) == nil {
                let index = nameToVerticeIndexDict.count
                nameToVerticeIndexDict[mapping.0] = index
                vertices.append(Vertice(id: index, name: mapping.0))
            }
            
            if vertice(for: mapping.1) == nil {
                let index = nameToVerticeIndexDict.count
                nameToVerticeIndexDict[mapping.1] = index
                vertices.append(Vertice(id: index, name: mapping.1))
            }
        }
        
        let graph = UndirectedGraph(vertices: vertices)
        
        nameMappings.forEach { mapping in
            if let firstVertice = vertice(for: mapping.0), let secondVertice = vertice(for: mapping.1) {
                graph.addEdge(v1: firstVertice, v2: secondVertice)
            }
        }
        
        return graph
    }
    
    private func connectedNames(graph: UndirectedGraph, for name: String) throws -> Set<String> {
        var connected = Set<String>()
        
        guard let startVertice = vertice(for: name) else {
            return connected
        }
        
        let nameQueue = Queue<Vertice>()
        nameQueue.enqueue(val: startVertice)
        while !nameQueue.isEmpty() {
            let currentVertice = try nameQueue.dequeue()
            connected.insert(currentVertice.name)
            
            let neighbours = graph.neighbours(v: currentVertice)
            var currentHead = neighbours.head
            while let curHead = currentHead {
                let curNeighbour = curHead.val
                
                if !connected.contains(curNeighbour.name) {
                    nameQueue.enqueue(val: curNeighbour)
                }
                
                currentHead = currentHead?.next
            }
        }
        
        return connected
    }
    
    private func vertice(for name: String) -> Vertice? {
        guard let index = nameToVerticeIndexDict[name] else {
            return nil
        }
        
        return vertices[index]
    }
}

open class NameFrequency: Equatable {
    let name: String
    var frequency: Int
    
    init(name: String, frequency: Int) {
        self.name = name
        self.frequency = frequency
    }
    
    public static func == (lhs: NameFrequency, rhs: NameFrequency) -> Bool {
        lhs.name == rhs.name && lhs.frequency == rhs.frequency
    }
}
