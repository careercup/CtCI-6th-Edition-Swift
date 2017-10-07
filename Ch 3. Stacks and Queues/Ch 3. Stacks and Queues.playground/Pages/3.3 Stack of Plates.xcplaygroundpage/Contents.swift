import Foundation

/*:
 3.3 Stack of Plates:
 Implement a SetOfStacks data structure that handles pushing elements onto 
 the stack when the count of elements exceeds a threshold. SetOfStacks should 
 be composed of several stacks and should create a new stack once the previous 
 stack exceeds its threshold. push() and pop() should behave as in a single stack.
 */

struct SetOfStacks<Element> {
    
    fileprivate var maxSize = 0
    fileprivate var stacks = [Stack<Element>]()
    fileprivate var stackCounts = [Int]()
    
    init(maxSize: Int) {
        guard maxSize >= 0 else { return }
        self.maxSize = maxSize
    }
}

extension SetOfStacks {
    
    mutating func push(_ value: Element) {
        if var stack = stacks.last, stackCounts.last ?? 0 < maxSize {
            stack.push(value)
            stackCounts[stackCounts.count - 1] += 1
            return stacks[stacks.count - 1] = stack
        }
        var stack = Stack<Element>()
        stack.push(value)
        stacks.append(stack)
        stackCounts.append(1)
    }
    
    mutating func pop() -> Element? {
        return popAt(index: stacks.count - 1)
    }
    
    var peek: Element? {
        return stacks.last?.peek
    }
}


/*:
 Follow up: implement popAt(index: Int), which pops the ith stack
 */
extension SetOfStacks {
    
    mutating func popAt(index: Int) -> Element? {
        guard index < stacks.count else { return nil }
        var stack = stacks[index]
        let element = stack.pop()
        if stack.isEmpty {
            stacks.remove(at: index)
            stackCounts.removeLast()
        }
        else {
            stacks[index] = stack
            stackCounts[stackCounts.count - 1] -= 1
        }
        return element
    }
}

extension SetOfStacks: CustomStringConvertible {
    
    var description: String {
        var s = ""
        for i in 0..<stacks.count {
            s += "stack \(i): count \(stackCounts[i]) \(stacks[i].description)\n"
        }
        return s
    }
}

var elements = [Int]()
for i in 0..<20 {
    elements.append(i)
}

var stacks = SetOfStacks<Int>(maxSize: 10)
for i in 0..<elements.count {
    stacks.push(elements[i])
}

stacks.push(21)
stacks.push(11)
stacks.push(12)
assert(stacks.pop() == 12)
assert(stacks.peek == 11)
assert(stacks.pop() == 11)
assert(stacks.pop() == 21)

for x in elements.reversed() {
    assert(stacks.peek == x, "\(String(describing: stacks.peek))  \(x)")
    stacks.pop()
}

for i in 0..<elements.count {
    stacks.push(elements[i])
}

for x in (0..<10).reversed() {
    let e = stacks.popAt(index: 0)
    assert(e == x, "\(String(describing: e)) \(x)")
}

for x in (10..<20).reversed() {
    let e = stacks.popAt(index: 0)
    assert(e == x, "\(String(describing: e)) \(x)")
}
