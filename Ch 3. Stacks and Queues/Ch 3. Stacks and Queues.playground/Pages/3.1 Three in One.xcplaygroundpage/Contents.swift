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
    
    mutating func push(_ element: Element, onToStack: Int) {
        guard onToStack >= 0 && onToStack < stacks.count else { return }
        var stack = stacks[onToStack]
        stack.append(element)
        stacks[onToStack] = stack
    }

    mutating func pop(stack i: Int) -> Element? {
        guard i >= 0 && i < stacks.count else { return nil }
        var stack = stacks[i]
        let element = stack.popLast()
        stacks[i] = stack
        return element
    }

    mutating func peek(stack i: Int) -> Element? {
        guard i >= 0 && i < stacks.count else { return nil }
        return stacks[i].last
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
    multiStack.push(elements[i], onToStack: i)
}

multiStack.push(21, onToStack: 1)
multiStack.push(11, onToStack: 0)
multiStack.push(12, onToStack: 0)
assert(multiStack.pop(stack: 0) == 12)
assert(multiStack.peek(stack: 1) == 21)
assert(multiStack.pop(stack: 1) == 21)
assert(multiStack.pop(stack: 0) == 11)

for i in 0..<elements.count {
    assert(multiStack.peek(stack: i) == elements[i])
}
