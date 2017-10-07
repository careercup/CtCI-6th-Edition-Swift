import Foundation

//: 2.2 Return kth to last element in a singly linked list

extension List {
    
    func kthToLastElement(k: Int) -> Element? {
        let dropCount = count - 1 - k
        guard dropCount >= 0 else { return nil }
        return dropFirst(dropCount).head
    }
}

func testKthToLastElement() {
    let randomInts = Array<Int>(randomIntUpperBound: 100, randomIntCount: 2.pow(5))
    let list = List(array: randomInts)
    
    randomInts.enumerated().forEach { i, element in
        let kthToLast = list.kthToLastElement(k: i)
        assert(randomInts[randomInts.count - 1 - i] == kthToLast)
    }
}

ApplyConcurrently(iterations: 2.pow(5)).apply {
    testKthToLastElement()
}
