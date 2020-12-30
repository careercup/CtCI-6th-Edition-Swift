//
//  AppointmentTimeOptimizer.swift
//  
//
//  Created by Stefan Jaindl on 11.12.20.
//

import Foundation

//Given an array of minutes, find the maximum nr. of minutes where no 2 adjacent indexes can be choosen.
open class AppointmentTimeOptimizer {
    public init() { }
    
    //O(N) time + O(N) space
    open func calculateMaxPossibleAppointmentTime(from minutes: [Int]) -> Int {
        var lookup: [Int: Int] = [:] //lookup table from array index to minutes
        
        return calculateMaxMinutesRecursive(from: minutes, index: 0, lookup: &lookup)
    }
    
    private func calculateMaxMinutesRecursive(from minutes: [Int], index: Int, lookup: inout [Int: Int]) -> Int {
        guard index < minutes.count else {
            return 0
        }
        
        let minutesNextSpot: Int
        if let lookedupMinutes = lookup[index + 2] {
            minutesNextSpot = lookedupMinutes
        } else {
            minutesNextSpot = calculateMaxMinutesRecursive(from: minutes, index: index + 2, lookup: &lookup)
            lookup[index + 2] = minutesNextSpot
        }
        
        let minutesAfterNextSpot: Int
        if let lookedupMinutes = lookup[index + 3] {
            minutesAfterNextSpot = lookedupMinutes
        } else {
            minutesAfterNextSpot = calculateMaxMinutesRecursive(from: minutes, index: index + 3, lookup: &lookup)
            lookup[index + 3] = minutesAfterNextSpot
        }
        
        return minutes[index] + max(minutesNextSpot, minutesAfterNextSpot)
    }
    
    //O(N) time + O(1) space
    open func calculateMaxMinutesIterative(from minutes: [Int]) -> Int {
        guard !minutes.isEmpty else {
            return 0
        }
        
        var index = minutes.count - 1
        
        var lastBest = 0 //best index + 1
        var lastLastBest = 0 //best index + 2
        while index >= 0 {
            let currentBest = max(minutes[index] + lastLastBest, lastBest)
            lastLastBest = lastBest
            lastBest = currentBest
            
            index -= 1
        }
        
        return max(lastBest, lastLastBest)
    }
}
