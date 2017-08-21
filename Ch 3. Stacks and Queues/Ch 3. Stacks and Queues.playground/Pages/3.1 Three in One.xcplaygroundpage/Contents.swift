import Foundation

/*:
 3.1 Three in One:
 Implement three stacks using a single array
 */

struct MultiStack<Element> {
    
    fileprivate var stacks = [[Element]]()
    
    init(stackCount: Int) {
        guard stackCount >= 0 else { return }
        for _ in 0..<stackCount {
            stacks.append([Element]())
        }
    }
}

extension MultiStack {
    
    mutating func push(_ element: Element, onto stack: Int) {
        guard stack >= 0 && stack < stacks.count else { return }
        var item = stacks[stack]
        item.append(element)
        stacks[stack] = item
    }
    
    mutating func pop(out stack: Int) -> Element? {
        guard stack >= 0 && stack < stacks.count else { return nil }
        var item = stacks[stack]
        let element = item.popLast()
        stacks[stack] = item
        return element
    }
    
    mutating func peek(into stack: Int) -> Element? {
        guard stack >= 0 && stack < stacks.count else { return nil }
        return stacks[stack].last
    }
}

extension MultiStack: CustomStringConvertible {
    
    var description: String {
        var s = ""
        for i in 0..<stacks.count {
            s += "stack \(i): \(stacks[i].reversed().description)\n"
        }
        return s
    }
}

var elements = [10, 20, 30, 40]
var multiStack = MultiStack<Int>(stackCount: elements.count)

for i in 0..<elements.count {
    multiStack.push(elements[i], onto: i)
}

multiStack.push(21, onto: 1)
multiStack.push(11, onto: 0)
multiStack.push(12, onto: 0)
assert(multiStack.pop(out: 0) == 12)
assert(multiStack.peek(into: 1) == 21)
assert(multiStack.pop(out: 1) == 21)
assert(multiStack.pop(out: 0) == 11)

for i in 0..<elements.count {
    assert(multiStack.peek(into: i) == elements[i])
}
