import Foundation

/*:
 3.4 Queue via Stacks:
 Implement a MyQueue data structure that implements a queue using two stacks.
 */

struct MyQueue<Element: Comparable> {
    
    fileprivate var stack = Stack<Element>()
    fileprivate var placeHolderStack = Stack<Element>()
}

extension MyQueue {
    
    mutating func enqueue(value: Element) {
        
        while let top = stack.pop() {
            placeHolderStack.push(top)
        }
        stack.push(value)
        while let top = placeHolderStack.pop() {
            stack.push(top)
        }
    }
    
    mutating func dequeue() -> Element? {
        return stack.pop()
    }
    
    var peek: Element? {
        return stack.peek
    }
    
    var isEmpty: Bool {
        return stack.peek == nil
    }
}

extension MyQueue: CustomStringConvertible {
    
    var description: String {
        var description = ""
        var stack = self.stack
        while let top = stack.pop() {
            description += "\(top),"
        }
        description.dropLast()
        return description
    }
}

var queue = MyQueue<Int>()

for i in 0..<5 {
    queue.enqueue(value: i)
}
for i in 0..<5 {
    let value = queue.dequeue()
    assert(value == i)
}
assert(queue.isEmpty)
