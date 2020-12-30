//
//  Vertice.swift
//  DataStructuresAlgs
//
//  Created by Stefan Jaindl on 01.04.20.
//  Copyright © 2020 Stefan Jaindl. All rights reserved.
//

import Foundation

open class Vertice: NSObject, Comparable {
    
    public static func < (lhs: Vertice, rhs: Vertice) -> Bool {
        return lhs.distanceTo < rhs.distanceTo
    }
    
    static func == (lhs: Vertice, rhs: Vertice) -> Bool {
        return lhs.id == rhs.id
    }
    
    public var id: Int
    
    public var name: String
    
    //Needed for topological sort:
    public var inboundCount: Int = 0
    
    //Needed for Djikstra + Prim's MST (weight):
    public var distanceTo: Int = 0
    
    //Needed for Prim's MST:
    public var minIngoingEdge: Edge?
    
    public var weight: Int {
        get {
            return distanceTo
        }
        set (weight) {
            distanceTo = weight
        }
    }
    
    public var visited: Bool = false
    
    public init(id: Int, name: String = "") {
        self.id = id
        self.name = name
    }
    
//    public override static func == (lhs: Vertice, rhs: Vertice) -> Bool {
//        return lhs.id == rhs.id
//    }
}
