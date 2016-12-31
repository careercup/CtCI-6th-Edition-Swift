import Foundation

/*:
 3.5 Sort Stack:
 Sort a stack such that the smallest items are on the top. You can use an additional
 temp stack, but you may not copy into another data structure. SortStack supports
 sort, push, pop, peek, and isEmpty.
 */

public struct SortableStack<Element: Comparable> {
    
    fileprivate var elements = [Element]()
}

public extension SortableStack {
    
    mutating func push(_ value: Element) {
        elements.append(value)
    }
    
    mutating func pop() -> Element? {
        return elements.popLast()
    }
    
    var peek: Element? {
        return elements.last
    }
    
    var isEmpty: Bool {
        return peek == nil
    }
}


extension SortableStack: CustomStringConvertible {
    
    public var description: String {
        return elements.reversed().description
    }
}


extension SortableStack {
    
    mutating func sort() {
        var placeholder = SortableStack<Element>()
        while let x = pop() {
            while let y = placeholder.peek, y > x {
                push(placeholder.pop()!)
            }
            placeholder.push(x)
        }
        while let y = placeholder.pop() {
            push(y)
        }
    }
}

var stack = SortableStack<Int>()
var array = [7,2,4,6,3,8,5]
array.forEach { x in
    stack.push(x)
}
stack.sort()
array.sort()
array.forEach { x in
    assert(x == stack.pop())
}

