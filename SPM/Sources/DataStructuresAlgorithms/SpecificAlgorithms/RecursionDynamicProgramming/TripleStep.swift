//
//  TripleStep.swift
//  
//
//  Created by Stefan Jaindl on 13.08.20.
//

import Foundation

open class TripleStep {
    
    public init() { }
    
    open func tripleStep(for steps: Int) -> Int {
        var currentStep = steps - 1
        var previous = 0
        var previousPrevious = 0
        var previousPreviousPrevious = 0
        
        while currentStep > 0 {
            //3 base cases
            if currentStep == steps - 1 {
                previous = 1
            } else if currentStep == steps - 2 {
                previous = 2
                previousPrevious = 1
            } else if currentStep == steps - 3 {
                previous = 4
                previousPrevious = 2
                previousPreviousPrevious = 1
            } else {
                //normal case
                let resultAtStep = previous + previousPrevious + previousPreviousPrevious
                previousPreviousPrevious = previousPrevious
                previousPrevious = previous
                previous = resultAtStep
            }
            
            currentStep -= 1
        }
        
        return previous
    }
}
