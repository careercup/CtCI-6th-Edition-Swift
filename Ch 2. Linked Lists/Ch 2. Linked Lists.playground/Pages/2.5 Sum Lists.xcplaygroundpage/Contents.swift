import Foundation

/*:
 2.5
 Two numbers are represented by two singly linked lists in which each node is a digit. 
 The lists have the digits in reverse order, so that the 1's digit is at the head of the list. 
 Sum the two lists and return the result as a list — e.g.:
 
 Input: `7 -> 1 -> 6`  +  `5 -> 9 -> 2, i.e. 617 + 295` \
 Output: `2 -> 1 -> 9,  i.e. 912`
 */

extension List where Element: FixedWidthInteger {
    
    func sum(integerListReversed: List) -> List {
        return sum(rightSide: integerListReversed, carry: 0, result: List())
    }
    
    private func sum(rightSide: List, carry: Element, result: List) -> List {
        guard !isEmpty || !rightSide.isEmpty else {
            return carry > 0 ? carry ++ result : result
        }
        let left = head ?? 0
        let right = rightSide.head ?? 0
        let sum = left + right + carry
        
        if sum >= 10 {
            let remainder = sum % 10
            return remainder ++ tail.sum(rightSide: rightSide.tail, carry: 1, result: result)
        }
        return sum ++ tail.sum(rightSide: rightSide.tail, carry: 0, result: result)
    }
}

public extension FixedWidthInteger {
    
    func digitsArray() -> [Self] {
        return digitsArray(digits: [])
    }
    
    private func digitsArray(digits: [Self]) -> [Self] {
        guard self > 0 else { return digits }
        let digit = self % 10
        let quotient = self / 10
        return quotient.digitsArray(digits: [digit] + digits)
    }
}

func testSumListsReversed() {
    
    let x = 1000.arc4random_uniform()
    let y = 100.arc4random_uniform()
    
    let leftList = List(array: x.digitsArray().reversed())
    let rightList = List(array: y.digitsArray().reversed())
    let summedList = leftList.sum(integerListReversed: rightList)
    
    let xySumDigits = (x + y).digitsArray()
    assert(summedList == List(array: xySumDigits.reversed()), "\(summedList) != xyDigits)")
}

ApplyConcurrently(iterations: 2.pow(5)).apply {
    testSumListsReversed()
}


/*:
 Follow Up: Suppose the digits in the lists are in order. Sum the two lists and return the result as a
 list
 */

extension List where Element: FixedWidthInteger, Element.Stride: SignedInteger {
    
    func sum(integerListOrdered: List) -> List {
        let (longer, shorter) = longerAndShorterCollections(other: integerListOrdered)
        let range = 0..<longer.count - shorter.count
        let paddedList = range.reduce(shorter) { list, _ in 0 ++ list }
        let sum = longer.reversedSum(rightSide: paddedList, exponent: longer.count - 1)
        return List(array: sum.digitsArray())
    }
    
    private func reversedSum(rightSide: List, exponent: Int, result: Element = 0) -> Element {
        guard let left = head, let right = rightSide.head else { return result }
        let elementSum = left + right
        
        let sum = elementSum * numericCast(10.pow(exponent))
        return tail.reversedSum(rightSide: rightSide.tail, exponent: exponent - 1, result: sum + result)
    }
}

func testSumOrdered() {
    let x = 1000.arc4random_uniform()
    let y = 100.arc4random_uniform()
    let leftList = List(array: x.digitsArray())
    let rightList = List(array: y.digitsArray())
    let summedList = leftList.sum(integerListOrdered: rightList)
    let xySum = x + y
    assert(summedList == List(array: xySum.digitsArray()), "\(summedList) != xyDigits)")
}


ApplyConcurrently(iterations: 2.pow(5)).apply {
    testSumOrdered()
}


