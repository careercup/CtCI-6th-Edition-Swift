import Foundation

/*: 
 2.4 Partition a singly linked list around a value `x`, such that all nodes `< x` come before all nodes `>= x`.
    
 If x is contained in the list, x only needs to be after the elements less than x.
 The partition element can appear anywhere in the "right partition"; it does not need to appear between the left and right partitions — e.g.:
 
 Input:    `3 -> 5 -> 8 -> 5 -> 10 -> 2 -> 1`  (partition = 5) \
 Output: `3 -> 1 -> 2 -> 10 -> 5 -> 5 -> 8`

*/

extension List {
    
    func partition(isOrderedBefore: (Element) -> Bool) -> List {
        let (left, right) = partition(isOrderedBefore)
        return left ++ right
    }
    
    private func partition(_ isLeft: (Element) -> Bool) -> (List, List) {
        guard let head = head else { return (self, self) }
        let (left, right) = tail.partition(isLeft)
        if isLeft(head) {
            return (head ++ left, right)
        }
        else {
            return (left, head ++ right)
        }
    }
}

func testPartition(array: [Int], partitionValue: Int) {
    let list = List(array: array)
    let partitioned = list.partition(isOrderedBefore: { $0 < partitionValue } )
    
    partitioned.reduce(false) {
        if $1 < partitionValue {
            assert($0 == false)
            return false
        }
        return true
    }
}

testPartition(array: [3,5,8,5,10,2,1], partitionValue: 5)

ApplyConcurrently(iterations: 2.pow(5)).apply {
    let randomIntArray = Array<Int>(randomInUpperBound: 100, randomIntCount: 2.pow(5))
    testPartition(array: randomIntArray, partitionValue: Int.random(in: 0...100))      
}
