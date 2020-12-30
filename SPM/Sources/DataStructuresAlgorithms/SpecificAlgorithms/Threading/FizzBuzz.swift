//
//  FizzBuzz.swift
//  
//
//  Created by Stefan Jaindl on 09.10.20.
//

import Foundation

open class FizzBuzz {
    
    let targetNumber: Int
    var fizzBuzzData = FizzBuzzData()
    
    public init(targetNumber: Int) {
        self.targetNumber = targetNumber
    }
    
    open func play() {
        let threads: [FizzBuzzThread] = [
            FizzBuzzThread(id: 1, targetNumber: targetNumber, validator: { $0 % 3 == 0 && $0 % 5 == 0 }, fizzBuzzData: fizzBuzzData, output: { _ in "FizzBuzz" }),
            FizzBuzzThread(id: 2, targetNumber: targetNumber, validator: { $0 % 3 != 0 && $0 % 5 == 0 }, fizzBuzzData: fizzBuzzData, output: { _ in "Buzz" }),
            FizzBuzzThread(id: 3, targetNumber: targetNumber, validator: { $0 % 3 == 0 && $0 % 5 != 0 }, fizzBuzzData: fizzBuzzData, output: { _ in "Fizz"}),
            FizzBuzzThread(id: 4, targetNumber: targetNumber, validator: { $0 % 3 != 0 && $0 % 5 != 0 }, fizzBuzzData: fizzBuzzData, output: { number in "\(number)"})
        ]
        
        threads.forEach { thread in
            DispatchQueue.global().async {
                thread.play()
            }
        }
    }
}

open class FizzBuzzThread: Thread {
    let id: Int
    let targetNumber: Int
    let validator: (Int) -> Bool
    let fizzBuzzData: FizzBuzzData
    let output: (Int) -> String
    
    public init(id: Int, targetNumber: Int, validator: @escaping (Int) -> Bool, fizzBuzzData: FizzBuzzData, output: @escaping (Int) -> String) {
        self.id = id
        self.targetNumber = targetNumber
        self.validator = validator
        self.fizzBuzzData = fizzBuzzData
        self.output = output
    }
    
    open func play() {
        while fizzBuzzData.currentNumber <= targetNumber {
            if validator(fizzBuzzData.currentNumber) {
                //Sychronized access to shared data class
                fizzBuzzData.semaphore.wait()
                fizzBuzzData.result.append(output(fizzBuzzData.currentNumber))
                fizzBuzzData.currentNumber += 1
                fizzBuzzData.semaphore.signal()
            }
        }
    }
}

open class FizzBuzzData {
    var result: [String] = []
    var currentNumber = 1
    
    let semaphore = DispatchSemaphore(value: 1)
}
