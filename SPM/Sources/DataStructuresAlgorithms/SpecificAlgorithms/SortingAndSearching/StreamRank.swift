//
//  StreamRank.swift
//  
//
//  Created by Stefan Jaindl on 27.09.20.
//

import Foundation

open class StreamRank<T: Comparable> {
    var rankTree = CompressedAVLChildCountTree<T>()
    
    public init() { }
    
    open func track(value: T) {
        rankTree.insert(val: value)
    }
    
    open func rank(of value: T) -> Int {
        return rankTree.rank(of: value)
    }
}
