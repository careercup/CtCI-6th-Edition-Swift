//: Playground - noun: a place where people can play

import UIKit

extension Node {
    
    // MARK: Problem 2.1
    func removeDuplicates() {
        var uniqueSet = Set<Int>()
        var head:Node<T> = self
        // initial preparation before iterating
        uniqueSet.insert(head.data! as! Int)
        while (head.next != nil) {
            if uniqueSet.contains(head.next!.data as! Int) {
                head.next = head.next!.next // skip duplicate
            } else {
                uniqueSet.insert(head.next!.data as! Int)
                head = head.next!
            }
        }
    }
    
    // MARK: Problem 2.2
    func kthToLast(k: Int) -> Node<T> {
        var front = self.copy()
        var tail = self.copy()
        var frontIndex = 1
        
        while front.next != nil {
            front = front.next!
            if frontIndex >= k {
                tail = tail.next!
            }
            frontIndex += 1
        }
        return tail
    }
    
    class func deleteNode(delete: Node) -> Bool {
        guard delete.next != nil else {
           return false
        }
        let next = delete.next
        delete.data = next!.data
        delete.next = next!.next
        return true
    }
}

// Mark: Setup for all problems
var head = Node(data: 1)
head.append(4)
head.append(5)
head.append(6)
head.append(4)

// MARK: Test problem 2.1
print("before: ", terminator: "")
head.printList()
head.removeDuplicates()
print("removing duplicates")
print("after: ", terminator: "")
head.printList()

// MARK: Test problem 2.2
// Reusing the linked list from 2.1
let k = head.kthToLast(2) // 2nd to last is Node.data = 5
k.printList()

// MARK: Test problem 2.3
let delete = head.next!.next
print("deleteing \(delete!.data!)")
print("before: ", terminator: "")
head.printList()
Node.deleteNode(delete!)
print("after: ", terminator: "")
head.printList()

