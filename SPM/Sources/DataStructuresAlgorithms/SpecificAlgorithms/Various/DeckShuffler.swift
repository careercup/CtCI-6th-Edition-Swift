//
//  DeckShuffler.swift
//  
//
//  Created by Stefan Jaindl on 04.12.20.
//

import Foundation

open class DeckShuffler {
    public init() { }
    
    open func shuffle(deck: Deck) -> Deck {
        var cards = deck.cards
        for index in 0 ..< cards.count {
            let newIndex = Int.random(in: 0 ..< index + 1)
            let temp = cards[index]
            cards[index] = cards[newIndex]
            cards[newIndex] = temp
        }
        
        return Deck(cards: cards)
    }
}

public struct Deck {
    let cards: [Card]
    
    static func allCards() -> [Card] {
        return [
            Card(color: .cross, value: .two),
            Card(color: .cross, value: .three),
            Card(color: .cross, value: .four),
            Card(color: .cross, value: .five),
            Card(color: .cross, value: .six),
            Card(color: .cross, value: .seven),
            Card(color: .cross, value: .eight),
            Card(color: .cross, value: .nine),
            Card(color: .cross, value: .ten),
            Card(color: .cross, value: .jack),
            Card(color: .cross, value: .queen),
            Card(color: .cross, value: .king),
            Card(color: .cross, value: .ace),
            Card(color: .hearts, value: .two),
            Card(color: .hearts, value: .three),
            Card(color: .hearts, value: .four),
            Card(color: .hearts, value: .five),
            Card(color: .hearts, value: .six),
            Card(color: .hearts, value: .seven),
            Card(color: .hearts, value: .eight),
            Card(color: .hearts, value: .nine),
            Card(color: .hearts, value: .ten),
            Card(color: .hearts, value: .jack),
            Card(color: .hearts, value: .queen),
            Card(color: .hearts, value: .king),
            Card(color: .hearts, value: .ace),
            Card(color: .diamond, value: .two),
            Card(color: .diamond, value: .three),
            Card(color: .diamond, value: .four),
            Card(color: .diamond, value: .five),
            Card(color: .diamond, value: .six),
            Card(color: .diamond, value: .seven),
            Card(color: .diamond, value: .eight),
            Card(color: .diamond, value: .nine),
            Card(color: .diamond, value: .ten),
            Card(color: .diamond, value: .jack),
            Card(color: .diamond, value: .queen),
            Card(color: .diamond, value: .king),
            Card(color: .diamond, value: .ace),
            Card(color: .squades, value: .two),
            Card(color: .squades, value: .three),
            Card(color: .squades, value: .four),
            Card(color: .squades, value: .five),
            Card(color: .squades, value: .six),
            Card(color: .squades, value: .seven),
            Card(color: .squades, value: .eight),
            Card(color: .squades, value: .nine),
            Card(color: .squades, value: .ten),
            Card(color: .squades, value: .jack),
            Card(color: .squades, value: .queen),
            Card(color: .squades, value: .king),
            Card(color: .squades, value: .ace)
        ]
    }
}

public struct Card: Hashable {
    let color: CardColor
    let value: CardValue
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(value)
    }
}

public enum CardColor {
    case hearts
    case squades
    case diamond
    case cross
}

public enum CardValue: Int {
    case two = 2
    case three
    case four
    case five
    case six
    case seven
    case eight
    case nine
    case ten
    case jack
    case queen
    case king
    case ace
}
