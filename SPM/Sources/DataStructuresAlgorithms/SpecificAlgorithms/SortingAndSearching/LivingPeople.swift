//
//  LivingPeople.swift
//  
//
//  Created by Stefan Jaindl on 23.11.20.
//

import Foundation

open class LivingPeople {
    public init() { }
    
    //Returns year where most people are alive (any, if years have same alive count)
    open func yearsWithMostPeopleAlive(peoples: [People], minYear: Int, maxYear: Int = Calendar.current.component(.year, from: Date())) -> Int? {
        guard !peoples.isEmpty else {
            return nil
        }
        
        //Sort by date of birth
        let sortedPeople = peoples.sorted(by: { $0.yearOfBirth < $1.yearOfBirth })
        var currentAlive = 0
        var maxAlive = 0
        var maxAliveYear: Int?
        var toYearCount: [Int: Int] = [:]
        var currentYear = minYear
        
        for people in sortedPeople {
            if people.yearOfBirth > maxYear {
                return maxAliveYear
            }
            
            currentAlive += 1
            if let to = people.yearOfDeath {
                addOrIncrement(hashTable: &toYearCount, key: to, by: 1)
            }
            
            if currentYear != people.yearOfBirth {
                currentAlive -= toYearCount[currentYear - 1] ?? 0
                currentYear = people.yearOfBirth
            }
            
            if currentAlive > maxAlive {
                maxAlive = currentAlive
                maxAliveYear = currentYear
            }
        }
        
        return maxAliveYear
    }
    
    private func addOrIncrement(hashTable: inout [Int: Int], key: Int, by: Int) {
        if let currentValue = hashTable[key] {
            hashTable[key] = currentValue + by
        } else {
            hashTable[key] = by
        }
    }
}

public struct People {
    let name: String
    let yearOfBirth: Int
    let yearOfDeath: Int?
}
