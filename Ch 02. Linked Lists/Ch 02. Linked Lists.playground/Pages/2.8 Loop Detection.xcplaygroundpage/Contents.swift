import Foundation

/*:
 2.8 Given a singly linked, circular list, return the node at the beginning of the loop.
 
 A circular list is a (corrupt) linked list in which a node's next pointer points to
 an earlier node in the list.
 
 Input: `a -> b -> c -> d -> e -> c`  (The same c as before) \
 Output: `c`
 */

extension MutableList {
    
    func nodeBeginningLoop() -> MutableList? {
        return nodeBeginningLoop(advanceBy: 1)
    }
    
    private func nodeBeginningLoop(advanceBy: Int) -> MutableList? {
        guard !isEmpty else { return nil }
        guard self !== node(at: advanceBy) else { return self }
        return tail?.nodeBeginningLoop(advanceBy: advanceBy + 1)
    }
}

let list = MutableList(arrayLiteral: "a", "b", "c", "d", "e")
list.description
let listToAppend = MutableList(arrayLiteral: "a", "b", "c", "d", "e")
list.append(list: listToAppend)
list.description
assert(list.nodeBeginningLoop() == nil)

let circularList = MutableList(arrayLiteral: "a", "b", "c", "d", "e")
circularList.description
assert(circularList.nodeBeginningLoop() == nil)
let subList = circularList.tail?.tail
circularList.append(list: subList!)
assert(circularList.nodeBeginningLoop() === subList)


// customizing MutableList's debugDescription prevents the playground from recursing infintely
// when it prints a circular list
extension MutableList: CustomDebugStringConvertible {
    
    public var debugDescription: String {
        guard let head = head else { return "nil" }
        let description = "\(head)"
        if let tailHead = tail?.head {
            return description + " -> \(tailHead) ..."
        }
        return description
    }
}
