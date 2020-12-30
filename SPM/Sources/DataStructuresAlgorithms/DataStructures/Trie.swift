import Foundation

open class TrieNode {
    public let value: Character
    public var terminates: Bool
    public var childNodes: Dictionary<Character, TrieNode> = Dictionary()
    
    public init(value: Character, terminates: Bool = false) {
        self.value = value
        self.terminates = terminates
    }
}

open class Trie {
    public let root: TrieNode = TrieNode(value: " ")
    
    public init() { }
    
    open func insert(word: String) {
        insert(word: Array(word), node: root)
    }
    
    private func insert(word: [Character], node: TrieNode) {
        if word.isEmpty {
            return
        }
        
        var nextNode: TrieNode
        if let nextChildNode = node.childNodes[word[0]] {
            nextNode = nextChildNode
        } else {
            nextNode = TrieNode(value: word[0])
            node.childNodes[word[0]] = nextNode
        }
        
        if word.count == 1 {
            nextNode.terminates = true
        } else {
            let slice = word[1...]
            insert(word: Array(slice), node: nextNode)
        }
    }
    
    open func search(word: String) -> Bool {
        var curNode: TrieNode? = root
        
        var chars = Array(word)
        
        if chars.count < 1 {
            return false
        }
        
        while curNode != nil && chars.count > 0 {
            let char = chars[0]
            curNode = curNode?.childNodes[char]
            chars = Array(chars[1...])
            if chars.isEmpty, let curNode = curNode, curNode.terminates {
                return true
            }
        }
        
        return false
    }
}
