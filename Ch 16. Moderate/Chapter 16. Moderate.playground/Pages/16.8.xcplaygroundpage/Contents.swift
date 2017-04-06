import Foundation

/*:
 16.6 return the difference between the two smallest numbers in a and b
 */
extension Collection where Iterator.Element: IntegerArithmetic {
    
    func minDifference<C: Collection>(c: C) -> Iterator.Element? where C.Iterator.Element == Iterator.Element {
        guard !isEmpty && !c.isEmpty else { return nil }
        
        let leftC = sorted()
        let rightC = c.sorted(by: <)
        var minDiff = (leftC[0] - rightC[0]).absv
        var i = leftC.startIndex
        var k = rightC.startIndex
        
        while i != leftC.endIndex && k != rightC.endIndex {
            let left = leftC[i]
            let right = rightC[k]
            if (left - right).absv < minDiff {
                minDiff = (left - right).absv
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
