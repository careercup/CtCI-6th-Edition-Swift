//: Playground - noun: a place where people can play

import UIKit

// MARK: Problem 2.1
extension Node {
    
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
}

// MARK: Test problem 2.1

var head = Node(data: 1)
head.next = Node(data: 4)
head.next!.next = Node(data: 5)
head.next!.next!.next = Node(data: 6)
head.next!.next!.next!.next = Node(data: 4)
print("before: ", terminator: "")
head.printList()
head.removeDuplicates()
print("after: ", terminator: "")
head.printList()
