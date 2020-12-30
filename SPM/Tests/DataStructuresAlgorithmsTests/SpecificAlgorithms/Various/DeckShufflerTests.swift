//
//  DeckShufflerTests.swift
//  
//
//  Created by Stefan Jaindl on 04.12.20.
//

import Foundation
import XCTest
@testable import DataStructuresAlgorithms

open class DeckShufflerTests: XCTestCase {
    
    open func testShuffle() {
        let shuffler = DeckShuffler()
        
        var randomSet = Set<Card>()
        for _ in 0 ..< 10 {
            let shuffledDeck = shuffler.shuffle(deck: Deck(cards: Deck.allCards()))
            randomSet.insert(shuffledDeck.cards[0])
        }
        
        XCTAssertTrue(randomSet.count >= 8) //statistical assumption
    }
}
