//
//  DiningPhilosophers.swift
//  
//
//  Created by Stefan Jaindl on 07.10.20.
//

import Foundation

open class Chopstick {
    let index: Int
    let nslock = NSLock()
    var lockedCount = 0
    
    public init(index: Int) {
        self.index = index
    }
    
    open func lock() {
        nslock.lock()
    }
    
    open func unlock() {
        nslock.unlock()
        lockedCount += 1
    }
}

open class Philosopher: Thread {
    let philosopherName: String
    let left: Chopstick
    let right: Chopstick
    
    let queue = DispatchQueue(label: "philosophersQueue")
    
    public init(name: String, left: Chopstick, right: Chopstick) {
        philosopherName = name
        self.left = left
        self.right = right
    }
    
    open func eat() {
        queue.async {
            let lower = self.left.index < self.right.index ? self.left : self.right
            let higher = self.left.index >= self.right.index ? self.left : self.right
            lower.lock()
            higher.lock()
            
            Philosopher.sleep(forTimeInterval: 0.1)
            
            higher.unlock()
            lower.unlock()
        }
    }
}

