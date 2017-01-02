import Foundation

/*:
 3.2 Stack Min:
 Design a stack which (in addition to push and pop) has min, a function
 that returns the min element in O(1)
 */

struct MinStack<Element: Comparable> {
    
    fileprivate var array = [Element]()
    fileprivate var minArray = [Element]()
}

extension MinStack {
    
    mutating func push(_ value: Element) {
        array.append(value)
        if minArray.isEmpty {
            minArray.append(value)
        }
        else if value < minArray.last ?? value {
            minArray.append(value)
        }
    }
    
    mutating func pop() -> Element? {
        guard let last = array.popLast() else { return nil }
        if last == minArray.last {
            minArray.removeLast()
        }
        return last
    }
    
    var peek: Element? {
        return array.last
    }
}

extension MinStack: CustomStringConvertible {
    
    var description: String {
        return array.reversed().description
    }
}

extension MinStack {
    
    var min: Element? {
        return minArray.last
    }
}

var stack = MinStack<Int>()
stack.push(10)
stack.push(79)
stack.push(36)
stack.push(3)
assert(stack.peek == stack.min)
stack.pop()
assert(stack.peek == 36)
assert(stack.min == 10)
