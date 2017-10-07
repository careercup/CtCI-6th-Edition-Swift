import Foundation

//: 2.1 Remove duplicates from an unsorted singly linked list

extension List where Element: Hashable {
    
    func removeDuplicates() -> List {
        var set = Set<Element>()
        let list = reduce(List()) {
            guard !set.contains($1) else { return $0 }
            set.insert($1)
            return $1 ++ $0
        }
        return list.reversed()
    }
}

func testRemoveDuplicates(dupsRemoved: (_ list: List<Int>) -> List<Int>) {
    let randomInts = Array<Int>(randomIntUpperBound: 100, randomIntCount: 2.pow(2))
    let set = Set(randomInts)
    let randomUniqueInts = Array(set)
    let list = List(array: randomUniqueInts)
    let listWithDups = list.append(list: list)
    listWithDups.description
    assert(dupsRemoved(listWithDups) == list)
}

testRemoveDuplicates { list in
    list.removeDuplicates()
}


//: 2.1 Follow up: Remove duplicates from an unsorted linked list without using a buffer

extension List where Element: Hashable {
    
    func removeDuplicatesWithoutBuffer() -> List {
        let list = reduce(List()) {
            guard !$0.contains($1) else { return $0 }
            return $1 ++ $0
        }
        return list.reversed()
    }
}

testRemoveDuplicates { list in
    list.removeDuplicatesWithoutBuffer()
}

