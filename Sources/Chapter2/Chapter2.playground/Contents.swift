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
    
    // MARK: Problem 2.3
    class func deleteNode(delete: Node) -> Bool {
        guard delete.next != nil else {
            return false
        }
        let next = delete.next
        delete.data = next!.data
        delete.next = next!.next
        return true
    }
    
    // MARK: Problem 2.4
    func partition(data: Int) -> Node {
        var copy:Node = self
        var big:Node = self
        var small:Node = self
        
        while copy.next != nil {
            let next = copy.next
            if (copy.data as! Int) < data {
                copy.next = small
                small = copy
            } else {
                big.next = copy
                big = copy
            }
            copy = next!
        }
        big.next = nil
        return small
    }
    
    // MARK: Problem 2.5
    class func sum(list1: Node?, list2: Node?, carry: Int) -> Node<Int>? {
        if list1 == nil && list2 == nil && carry == 0 {
           return nil
        }
        var sumList:Node<Int>!
        var sum = carry
        if list1 != nil {
            sum += (list1!.data as! Int)
        }
        if list2 != nil {
            sum += (list2!.data as! Int)
        }
        
        sumList = Node<Int>(data: sum % 10)
        if list1 != nil || list2 != nil {
            let new1 = list1 != nil && list1!.next != nil ? list1!.next : nil
            let new2 = list2 != nil && list2!.next != nil ? list2!.next : nil
            sumList.append(Node.sum(new1, list2: new2, carry: sum / 10))
        }
        return sumList
    }

    // MARK: Problem 2.6
     func isPalindrome() -> Bool {
        var front:[Int] = []
        var back:[Int] = []
        var fast = self.copy()
        var slow = self.copy()
        while fast.next?.next != nil {
            front.append(slow.data as! Int)
            slow = slow.next!
            fast = fast.next!.next!
            
        }
        while slow.next != nil {
            back.append(slow.data! as! Int)
            slow = slow.next!
        }
        back.append(slow.data! as! Int)
        back = back.reverse()
        if front.count != back.count {
            back.popLast()
        }
        return front == back
    }
}

// Mark: Setup for all problems
var head = Node<Int>(data: 1)
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
print("deleting \(delete!.data!)")
print("before: ", terminator: "")
head.printList()
Node.deleteNode(delete!)
print("after: ", terminator: "")
head.printList()

// MARK: Test problem 2.4
head.append(2)
head.append(5)
head.append(9)
head.append(7)
head.printList()
let new = head.partition(5)
new.printList()

// MARK: Test problem 2.5
head.printList()
new.printList()
let sum:Node<Int> = Node.sum(head, list2: new, carry: 0)!
sum.printList()

// MARK: Test problem 2.6
let array = [1, 2, 3, 4, 3, 2, 1]
let array2 = [1, 2, 3, 4, 3, 2]
let isTrue = Node(arrayOfData: array)
let isFalse = Node(arrayOfData: array2)
print(isTrue.isPalindrome())
print(isFalse.isPalindrome())


