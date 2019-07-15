import Foundation

/*:
 16.6 Return the difference between the two smallest numbers in a and b
 */
extension Collection where Iterator.Element: FixedWidthInteger & SignedNumeric {
    
    func minDifference<C: Collection>(c: C) -> Iterator.Element? where C.Iterator.Element == Iterator.Element {
        guard !isEmpty && !c.isEmpty else { return nil }
        
        let leftC = sorted()
        let rightC = c.sorted(by: <)
        var minDiff = abs(leftC[0] - rightC[0])
        var i = leftC.startIndex
        var k = rightC.startIndex
        
        while i != leftC.endIndex && k != rightC.endIndex {
            let left = leftC[i]
            let right = rightC[k]
            let absVal = abs(left - right)
            if absVal < minDiff {
                minDiff = absVal
            }
            if left <= right {
                i += 1
            }
            else {
                k += 1
            }
        }
        return minDiff
    }
}

var a = [1,3,15,11,2]
var b = [23,127,235,19,8]

let result = a.minDifference(c: b)
assert(result ?? 0 == 3)
