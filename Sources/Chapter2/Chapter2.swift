// Cracking the Coding Interview 6th Edition Solutions

import Foundation

class Node {
  var next: Node?
  var data: Int
  
  init(data: Int) {
    self.data = data
  }
  
  func appendToTail(d: Int) {
    let end = Node(data: d)
    var n = self
    
    while let next = n.next {
      n = next
    }
    
    n.next = end
  }
}

// MARK: Question 2.1
extension Node {
  
  /// Time Complexity:  O(n)
  /// Space Complexity: O(n)
  func deleteDups(){
    
    var set = Set<Int>()
    
    var previous: Node? = nil
    var runner: Node? = self
    
    while let current = runner {
      if set.contains(current.data) {
        previous?.next = current.next
      } else {
        set.insert(current.data)
        previous = current
      }
      runner = current.next
    }
  }
  
  /// Time Complexity:  O(n^2)
  /// Space Complexity: O(1)
  func deleteDupsNoDS(){
    
    var externalRunner: Node? = self
    
    while let current = externalRunner {
      
      var runner = current
      
      while let next = runner.next {
        if next.data == current.data {
          runner.next = next.next
        } else {
          runner = next
        }
      }
      
      externalRunner = current.next
    }
  }
}

// MARK: Question 2.2
extension Node {
  /// Time Complexity:  O(n)
  /// Space Complexity: O(1)
  func kthLastElement(k: Int) -> Node? {
    
    if k <= 0 {
      return nil
    }
    var pointer1 = self
    var pointer2: Node? = self
    
    for _ in 0..<k {
      guard let _ = pointer2 else {
        return nil
      }
      pointer2 = pointer2?.next
    }
    
    while let p2 = pointer2 {
      pointer2 = p2.next
      pointer1 = pointer1.next!
    }
    
    return pointer1
  }
  
  
  /// Time Complexity:  O(n)
  /// Space Complexity: O(n)
  func kthLastElementRecursive(k: Int) -> Node? {
    
    var counter = 0
    return kthLastElemenst(self, counter: &counter, k:k)
  }
  
  private func kthLastElemenst(node: Node?, inout counter: Int, k: Int) -> Node? {
    
    guard let current = node else {
      return nil
    }
    
    if let res = kthLastElemenst(current.next, counter: &counter, k: k) {
      return res
    }
    
    counter += 1
    
    return counter == k ? current : nil
  }
}

// MARK: Question 2.3
extension Node {
  
  /// Time Complexity:  O(1)
  /// Space Complexity: O(1)
  class func deleteNode(node: Node) -> Bool {
    
    ///This problem cannot be solved if the node to be deleted is the last node.
    guard let next = node.next else {
      return false
    }
    
    node.data = next.data
    node.next = next.next
    return true
  }
}

// MARK: Question 2.4
extension Node {
  
  /// Time Complexity:  O(n)
  /// Space Complexity: O(1)
  /// 'Stable' solution
  class func partition(node: Node, x: Int) -> Node {
    
    var beforeStart: Node?
    var beforeEnd: Node?
    var afterStart: Node?
    var afterEnd: Node?
    
    var runner: Node? = node
    
    while let current = runner {
      runner = current.next
      current.next = nil
      
      if current.data < x {
        // Insert node into end of before list
        if beforeStart == nil {
          beforeStart = current
          beforeEnd = beforeStart
        } else {
          beforeEnd?.next = current
          beforeEnd = current
        }
      } else {
        // Insert node into end of after list
        if afterStart == nil {
          afterStart = current
          afterEnd = afterStart
        } else {
          afterEnd?.next = current
          afterEnd = current
        }
      }
    }
    
    guard let _ = afterStart else {
      return afterStart!
    }
    
    beforeEnd?.next = afterStart
    return beforeStart!
  }
}

// MARK: Question 2.4
extension Node {
  
  /// Time Complexity:  O(n)
  /// Space Complexity: O(1)
  class func addTwoNumbers(l1: Node?, _ l2: Node?) -> Node? {
    
    guard let _ = l1, _ = l2 else {
      return nil
    }
    
    guard let _ = l1 else {
      return l2
    }
    
    guard let _ = l2 else {
      return l1
    }
    
    var runnerL1 = l1
    var runnerL2 = l2
    
    var curry = 0
    var res: Node?
    var resTail: Node?
    
    while let l1 = runnerL1, l2 = runnerL2 {
      
      var sum = l1.data + l2.data + curry
      curry = sum / 10
      sum = sum % 10
      
      if res == nil {
        res = Node(data: sum)
        resTail = res
      } else {
        resTail!.next = Node(data: sum)
        resTail = resTail!.next
      }
      
      runnerL1 = l1.next
      runnerL2 = l2.next
    }
    
    while let l1 = runnerL1 {
      var sum = l1.data + curry
      curry = sum / 10
      sum = sum % 10
      resTail!.next = Node(data: sum)
      resTail = resTail!.next
      
      runnerL1 = l1.next
    }
    
    while let l2 = runnerL2 {
      var sum = l2.data + curry
      curry = sum / 10
      sum = sum % 10
      resTail!.next = Node(data: sum)
      resTail = resTail!.next
      
      runnerL2 = l2.next
    }
    
    if curry != 0 {
      resTail!.next = Node(data: curry)
    }
    
    return res
  }
}

extension Node {
  
  /// Time Complexity:  O(n)
  /// Space Complexity: O(1)
  func isPalindrome(head: ListNode?) -> Bool {
    
    guard let head = head else {
      return true
    }
    
    let mid = findMid(head)
    
    var secondHalf = mid.next
    
    reverse(&secondHalf)
    
    var runner = head
    
    while let current = secondHalf {
      if runner.val != current.val {
        return false
      }
      
      secondHalf = current.next
      runner = runner.next!
    }
    
    return true
  }
  
  private func findMid(head: ListNode) -> ListNode {
    
    var slowRunner = head
    var fastRunner = head
    
    while let next = fastRunner.next {
      if let nextNext = next.next {
        fastRunner = nextNext
        slowRunner = slowRunner.next!
      } else {
        fastRunner = next
      }
    }
    
    return slowRunner
  }
  
  private func reverse(inout head: ListNode?) {
    
    guard let _ = head else {
      return
    }
    
    var newHead: ListNode?
    
    var runner: ListNode? = head
    
    while let current = runner {
      
      runner = current.next
      current.next = nil
      
      if newHead == nil {
        newHead = current
      } else {
        current.next = newHead
        newHead = current
      }
    }
    
    head = newHead
  }
}

//  var length: Int {
//
//    var counter = 0
//
//    var runner: Node? = self
//    while let current = runner {
//      counter += 1
//      runner = current.next
//    }
//
//    return counter
//  }
