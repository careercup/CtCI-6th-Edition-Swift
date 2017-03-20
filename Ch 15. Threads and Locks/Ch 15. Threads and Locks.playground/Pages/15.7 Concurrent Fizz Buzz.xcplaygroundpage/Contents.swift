import Foundation

/*:
 15.7 Concurrent FizzBuzz: Implement a multithreaded version of FizzBuzz with four threads. One thread checks for divisibility by 3 and prints "Fizz". Another thread checks for divisibility by 5 and prints "Buzz". Another thread is responsibile for divisibility of 3 and 5 and prints "FizzBuzz". A fourth thread prints the numbers.
 */

struct FizzBuzzIteratorConcurrent: IteratorProtocol {
    
    private var range: CountableClosedRange<Int>
    private var index: ClosedRangeIndex<Int>
    
    init(n: Int) {
        precondition(n >= 1, "n must be >= 1")
        range = 1...n
        index = range.startIndex
    }
    
    mutating func next() -> String? {
        guard index < range.endIndex else { return nil }
        let next = range[index]
        index = range.index(after: index)
        var result = ""
        let fb = BlockOperation {
            if next % 3 == 0 && next % 5 == 0 {
                result = "FizzBuzz"
            }
        }
        let f = BlockOperation {
            if next % 3 == 0 && next % 5 != 0 {
                result = "Fizz"
            }
        }
        let b = BlockOperation {
            if next % 5 == 0 && next % 3 != 0 {
                result = "Buzz"
            }
        }
        let n = BlockOperation {
            if next % 3 != 0 && next % 5 != 0 {
                result = "\(next)"
            }
        }
        let queue = OperationQueue()
        queue.addOperations([fb, f, b, n], waitUntilFinished: true)
        return result
    }
}

struct FizzBuzzSequence: Sequence {
    
    let n: Int
    
    init(n: Int) {
        self.n = n
    }
    
    func makeIterator() -> FizzBuzzIteratorConcurrent {
        return FizzBuzzIteratorConcurrent(n: n)
    }
}

let sequence = FizzBuzzSequence(n: 16)
var results = sequence.map { $0 }
assert(results == ["1", "2", "Fizz", "4", "Buzz", "Fizz", "7", "8", "Fizz", "Buzz", "11", "Fizz", "13", "14", "FizzBuzz", "16"])
