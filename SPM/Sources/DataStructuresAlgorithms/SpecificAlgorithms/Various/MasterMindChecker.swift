//
//  MasterMindChecker.swift
//  
//
//  Created by Stefan Jaindl on 27.11.20.
//

import Foundation

public enum MasterMindColor {
    case red
    case yellow
    case blue
    case green
}

open class MasterMindChecker {
    public init() { }
    
    open func check(guess: [MasterMindColor], solution: [MasterMindColor]) throws -> MasterMindCheckResult {
        guard guess.count == solution.count, !guess.isEmpty else {
            throw NSError(domain: "MasterMind: Invalid guess or solution", code: 0, userInfo: nil)
        }
        
        var guessMisses: [MasterMindColor: Int] = [:]
        var solutionMisses: [MasterMindColor: Int] = [:]
        
        //1st pass: Check hits
        let hits = checkHits(guess: guess, solution: solution, guessMisses: &guessMisses, solutionMisses: &solutionMisses)
        
        //2nd pass: Check pseudohits
        let pseudoHits = checkPseudoHits(guessMisses: guessMisses, solutionMisses: solutionMisses)
        
        return MasterMindCheckResult(hits: hits, pseudohits: pseudoHits)
    }
    
    private func checkHits(guess: [MasterMindColor], solution: [MasterMindColor], guessMisses: inout [MasterMindColor: Int], solutionMisses: inout [MasterMindColor: Int]) -> Int {
        var hits = 0
        for index in 0 ..< guess.count {
            if guess[index] == solution[index] {
                hits += 1
            } else {
                createOrIncrement(hashTable: &guessMisses, for: guess[index])
                createOrIncrement(hashTable: &solutionMisses, for: solution[index])
            }
        }
        
        return hits
    }
    
    private func checkPseudoHits(guessMisses: [MasterMindColor: Int], solutionMisses: [MasterMindColor: Int]) -> Int {
        var pseudoHits = 0
        
        guessMisses.forEach { miss in
            if let pseudoSolution = solutionMisses[miss.key] {
                pseudoHits += min(miss.value, pseudoSolution)
            }
        }
        
        return pseudoHits
    }
    
    private func createOrIncrement(hashTable: inout [MasterMindColor: Int], for key: MasterMindColor) {
        if let value = hashTable[key] {
            hashTable[key] = value + 1
        } else {
            hashTable[key] = 1
        }
    }
}

public struct MasterMindCheckResult: Equatable {
    var hits: Int
    var pseudohits: Int
}
