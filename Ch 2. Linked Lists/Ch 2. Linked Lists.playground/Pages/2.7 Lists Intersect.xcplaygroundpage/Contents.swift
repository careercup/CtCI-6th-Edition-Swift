import Foundation

/*:
 2.7 Determine if two singly linked lists intersect, and return the intersecting node if they do. \
 Intersection is defined by reference not value, i.e. the lists intersect if the ith node of one list is the same by reference as the kth node of the other list.
 */

extension MutableList {
    
    func intersectingNode(other: MutableList) -> MutableList? {
        let (longer, shorter) = count > other.count ? (self, other) : (other, self)
        let list = longer.node(at: longer.count - shorter.count)
        var left = list
        var right: MutableList? = shorter
        while let _ = left?.tail, let _ = right?.tail {
            guard left !== right else { return left }
            left = left?.tail
            right = right?.tail
        }
        return nil
    }
}


let listToAppend = MutableList(arrayLiteral: 1,2)
listToAppend.description
var list = MutableList(arrayLiteral: 3,4,5)
list.description
assert(listToAppend.intersectingNode(other: list) == nil)
 
list.append(list: listToAppend)
list.description
let intersectingNode = list.intersectingNode(other: listToAppend)
assert(intersectingNode === listToAppend)
