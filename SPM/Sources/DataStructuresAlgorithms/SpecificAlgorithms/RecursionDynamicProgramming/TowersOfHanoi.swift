//
//  TowersOfHanoi.swift
//  
//
//  Created by Stefan Jaindl on 18.08.20.
//

import Foundation

open class TowerOfHanoi<T: Comparable & Hashable> {
    public let disks = Stack<T>()
    public let index: Int
    
    init(index: Int) {
        self.index = index
    }
    
    public func add(disk: T) throws {
        if !disks.isEmpty(), try disks.peek() <= disk {
            throw NSError(domain: "TowersOfHanoi: Cannot put larger disk on smaller one", code: 0, userInfo: nil)
        }
        
        disks.push(val: disk)
    }
    
    public func moveTopTo(otherTower: TowerOfHanoi) throws {
        let top = try disks.pop()
        try otherTower.add(disk: top)
    }
    
    public func moveDisks(numberOfDisks: Int, destination: TowerOfHanoi, buffer: TowerOfHanoi) throws {
        guard numberOfDisks > 0 else {
            return
        }
        
        //First move all disks except last from origin to buffer:
        try moveDisks(numberOfDisks: numberOfDisks - 1, destination: buffer, buffer: destination)
        
        //Move last (biggest) disk from origin to destination:
        try moveTopTo(otherTower: destination)
        
        //Move remaining n-1 disks from buffer to destination:
        try buffer.moveDisks(numberOfDisks: numberOfDisks - 1, destination: destination, buffer: self)
    }
}
