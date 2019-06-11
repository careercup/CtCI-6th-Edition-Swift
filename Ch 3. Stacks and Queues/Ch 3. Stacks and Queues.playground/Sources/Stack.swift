import Foundation

public struct Stack<Element> {
    
    private(set) var elements = [Element]()
    public init() {}
}

public extension Stack {
    
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


extension Stack: CustomStringConvertible {
    
    public var description: String {
        return elements.reversed().description
    }
}
