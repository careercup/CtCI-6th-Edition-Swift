//
//  KthMultiple.swift
//  
//
//  Created by Stefan Jaindl on 07.12.20.
//

import Foundation

open class KthMultiple {
    let multiples: [Int]
    
    public init(multiples: [Int]) {
        self.multiples = multiples
    }
    
    //Returns kth multiple that can only be divided by 3, 5, 7 or itself
    //Starting with: 1, 3, 5, 7, 9, 15, 21,...
    open func allToKthMultipleComposedOfOnlyLowestOddPrimes(k: Int) -> [Int] {
        guard k > 0 else {
            return []
        }
        
        var multiples: [Int] = []
        
        for currentNumber in 0 ... k {
            if isValidPrimeNumber(k: currentNumber) {
                multiples.append(currentNumber)
            }
        }
        
        return multiples
    }
    
    private func isValidPrimeNumber(k: Int) -> Bool {
        guard k % 2 != 0 else {
            //Even numbers are always divisible by 2, we can rule those numbers out
            return false
        }
        
        var remainder = k
        
        for primeFactor in multiples {
            while remainder % primeFactor == 0 {
                remainder /= primeFactor
            }
        }
        
        if multiples.contains(remainder) || remainder == 1 {
            return true
        }
        
        return false
    }
    
    open func allToKthMultipleComposedOfOnlyLowestOddPrimesFast(k: Int) -> [Int] {
        guard k > 0 else {
            return []
        }
        
        var computedPrimes = Set<Int>()
        
        addNumberRecursive(product: 1, computed: &computedPrimes, target: k)
        
        return computedPrimes.sorted()
    }
    
    private func addNumberRecursive(product: Int, computed: inout Set<Int>, target: Int) {
        if product == target {
            computed.insert(target)
        }
        
        if product > target {
            return
        }
        
        if computed.contains(product) {
            return
        } else {
            computed.insert(product)
        }
        
        for multiple in multiples {
            if product <= target / multiple { //Avoid arithmetic overflow
                addNumberRecursive(product: product * multiple, computed: &computed, target: target)
            }
        }
    }
    
    open func kthMultipleComposedOfOnlyLowestOddPrimes(k: Int) throws -> Int? {
        guard k > 0 else {
            return nil
        }
        
        let multiples = [3, 5, 7]
        
        if k <= 4 {
            let muliplesWithOne = [1] + multiples
            return muliplesWithOne[k - 1]
        }
        
        let deque = DoubleLinkedList<Int>()
        var count = 1
        
        var computed = Set<Int>()
        enqueue(val: 1, deque: deque)
        
        while let nextMultiple = try deque.removeFirst() {
            for multiple in multiples {
                if count == k {
                    return try deque.removeLast()?.val
                }
                
                let value = nextMultiple.val * multiple
                if !computed.contains(value) {
                    insert(value: value, computed: &computed, deque: deque)
                    count += 1
                }
            }
        }
        
        return nil
    }
    
    private func insert(value: Int, computed: inout Set<Int>, deque: DoubleLinkedList<Int>) {
        if !computed.contains(value) {
            enqueue(val: value, deque: deque)
        }
        
        computed.insert(value)
    }
    
    private func enqueue(val: Int, deque: DoubleLinkedList<Int>) {
        var current = deque.tail
        let node = Node(val: val)
        if current == nil {
            deque.add(node: node)
            return
        } else if let current = current, current.val < val {
            deque.add(node: node)
            return
        }
        
        while let cur = current {
            if cur.val > val {
                if cur == deque.head {
                    node.next = cur
                    cur.prev = node
                    deque.head = node
                    return
                } else {
                    current = cur.prev
                }
            } else {
                cur.next?.prev = node
                node.prev = cur
                cur.next = node
                return
            }
        }
    }
}
