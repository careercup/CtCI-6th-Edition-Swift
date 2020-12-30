//
//  AnimalShelter.swift
//  
//
//  Created by Stefan Jaindl on 18.06.20.
//

import Foundation

open class AnimalShelter {
    private var head: Node<Animal>?
    private var dogTail: Node<Animal>?
    private var catTail: Node<Animal>?
    
    public init() { }
    
    open func enqueue(animal: Animal) {
        let node = Node(val: animal)
        
        if head == nil {
            head = node
        }
        
        if animal is Dog {
            if dogTail == nil {
                dogTail = node
            } else {
                dogTail?.next = node
                node.prev = dogTail
                dogTail = node
            }
        } else if animal is Cat {
           if catTail == nil {
                catTail = node
            } else {
                catTail?.next = node
                node.prev = catTail
                catTail = node
            }
        }
    }
    
    open func dequeueDog() throws -> Dog {
        guard let dog = dogTail?.val as? Dog else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        dogTail = dogTail?.prev
        dogTail?.next = nil
        
        if dogTail == nil, head?.val is Dog {
            head = nil
        }
        
        return dog
    }
    
    open func dequeueCat() throws -> Cat {
        guard let cat = catTail?.val as? Cat else {
            throw NSError(domain: "Stack: Invalid call", code: 0, userInfo: nil)
        }
        
        catTail = catTail?.prev
        catTail?.next = nil
        
        if catTail == nil, head?.val is Cat {
            head = nil
        }
        
        return cat
    }
    
    open func dequeueAny() throws -> Animal {
        //Is the last element a dog?
        if catTail?.next != nil {
            return try dequeueDog()
        }
        
        return try dequeueCat()
    }
    
}

open class Animal: Hashable, Equatable {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }
    
    public static func == (lhs: Animal, rhs: Animal) -> Bool {
        return lhs.name == rhs.name
    }
}

open class Dog: Animal { }

open class Cat: Animal { }
