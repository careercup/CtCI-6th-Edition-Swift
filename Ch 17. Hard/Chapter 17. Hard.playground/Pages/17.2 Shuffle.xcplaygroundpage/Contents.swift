import Foundation

//: Write a method to shuffle a deck of cards. It must be a perfect shuffle.

func shuffleRecursively(_ cards: inout [Int], _ i: Int) {
    if i == 0 { return }
    
    shuffleRecursively(&cards, i - 1)
    let k = Int.random(in: 0...i)
    
    cards.swapAt(k, i)
    return
}

func shuffle(_ cards: inout [Int]) {
    for i in 0..<cards.count {
        let k = Int.random(in: 0...i)
        cards.swapAt(k, i)
    }
}

var cards = [Int](1...10)
shuffle(&cards)
