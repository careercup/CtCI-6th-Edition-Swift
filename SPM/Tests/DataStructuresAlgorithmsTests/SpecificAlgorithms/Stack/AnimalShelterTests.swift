//
//  SortStackTests.swift
//  
//
//  Created by Stefan Jaindl on 14.06.20.
//

import Foundation

import XCTest
@testable import DataStructuresAlgorithms

open class AnimalShelterTests: XCTestCase {
    
    open func testAnimalShelter() throws {
        let animalShelter = AnimalShelter()
        
        animalShelter.enqueue(animal: Dog(name: "Waldi"))
        animalShelter.enqueue(animal: Dog(name: "Lumpi"))
        animalShelter.enqueue(animal: Cat(name: "Gina"))
        animalShelter.enqueue(animal: Cat(name: "KitCat"))
        animalShelter.enqueue(animal: Cat(name: "Tom"))
        animalShelter.enqueue(animal: Dog(name: "Wuff"))
        
        XCTAssertEqual(try animalShelter.dequeueCat().name, "Tom")
        XCTAssertEqual(try animalShelter.dequeueDog().name, "Wuff")
        XCTAssertEqual(try animalShelter.dequeueAny().name, "KitCat")
    }
}
