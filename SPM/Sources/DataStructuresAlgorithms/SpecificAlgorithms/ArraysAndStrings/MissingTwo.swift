//
//  MissingTwo.swift
//  
//
//  Created by Stefan Jaindl on 13.12.20.
//

import Foundation

open class MissingTwo {
    public init() { }
    
    //Finds missing number in array from 1 ... N
    open func findMissingNumber(in array: [Int]) -> Int? {
        guard !array.isEmpty else {
            return nil
        }
        
        let arraySum = sum(of: array)
        let expectedSum = expected(totalCount: array.count + 1) //includes missing int
        
        return expectedSum - arraySum
    }
    
    open func findMissingTwoNumbers(in array: [Int]) -> [Int] {
        guard !array.isEmpty else {
            return []
        }
        
        let totalCount = array.count + 2
        let arraySum = sum(of: array)
        let expectedSum = expected(totalCount: totalCount) //includes 2 missing ints
        let lookup = buildLookupTable(of: array)
        
        let diff = expectedSum - arraySum
        
        //Search only possible diffs
        let max = totalCount % 2 == 0 ? diff / 2 - 1 : diff / 2
        for current in 1 ... max {
            if !lookup.contains(current) {
                //found!
                let other = diff - current
                return [current, other]
            }
        }
        
        return []
    }
    
    open func findMissingTwoNumbersWithLessSpace(in array: [Int]) -> [Int] {
        guard !array.isEmpty else {
            return []
        }
        
        let totalCount = array.count + 2
        let arraySum = sum(of: array)
        let arrayQuadraticSum = quadraticSum(of: array)
        let expectedArraySum = expected(totalCount: totalCount) //includes 2 missing ints
        let expectedArrayQuadraticSum = expectedQuadraticSum(totalCount: totalCount)
        
        let missingQuadraticSum = expectedArrayQuadraticSum - arrayQuadraticSum //the missing 2 ints are the 2 quadratics sums of this sum!
        let missingSum = expectedArraySum - arraySum //this is the sum of the 2 missing ints
        
        for number in 1 ... Int(missingSum / 2) {
            let other = missingSum - number
            let numberQuadr = Int(pow(Double(number), 2))
            let otherQuadr = Int(pow(Double(other), 2))
            
            if numberQuadr + otherQuadr == missingQuadraticSum {
                return [number, other]
            }
        }
        
        return []
    }
    
    private func sum(of array: [Int]) -> Int {
        var arraySum = 0
        for number in array {
            arraySum += number
        }
        
        return arraySum
    }
    
    private func quadraticSum(of array: [Int]) -> Int {
        var arrayQuadraticSum = 0
        for number in array {
            arrayQuadraticSum += Int(pow(Double(number), 2))
        }
        
        return arrayQuadraticSum
    }
    
    private func expected(totalCount: Int) -> Int {
        let expected: Int
        
        if totalCount % 2 == 1 {
            expected = (totalCount / 2 + 1) * totalCount //odd
        } else {
            expected = (totalCount / 2) * totalCount + totalCount / 2
        }
        
        return expected
    }
    
    private func expectedQuadraticSum(totalCount: Int) -> Int {
        var expected = 0
        
        for number in 1 ... totalCount {
            expected += Int(pow(Double(number), 2))
        }
        
        return expected
    }
    
    private func buildLookupTable(of array: [Int]) -> Set<Int> {
        var set = Set<Int>()
        for element in array {
            set.insert(element)
        }
        
        return set
    }
}
