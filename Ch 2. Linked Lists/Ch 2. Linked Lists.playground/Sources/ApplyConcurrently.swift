//
//  ApplyConcurrently.swift
//
//  Created by Matthew Carroll on 8/10/16.
//  Copyright © 2016 Matthew Carroll. All rights reserved.
//

import Foundation

public struct ApplyConcurrently {
    
    let iterations: Int
    private let maxConcurrentOperations: Int
    
    public init(iterations: Int, maxConcurrentOperations: Int = OperationQueue.defaultMaxConcurrentOperationCount) {
        self.iterations = iterations
        self.maxConcurrentOperations = maxConcurrentOperations
    }
    
    public func apply(f: @escaping () -> ()) {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = maxConcurrentOperations
        for _ in 0..<iterations {
            queue.addOperation(f)
        }
        queue.waitUntilAllOperationsAreFinished()
    }
}
