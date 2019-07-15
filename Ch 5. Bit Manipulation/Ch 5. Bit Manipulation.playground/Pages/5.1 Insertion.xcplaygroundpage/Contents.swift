import Foundation


/*:
 You are given two 32 bit Ints, `n` and `m`, and two bit positions, `i` and `j`.
 
 Write a method to insert m into n so that m starts at bit j and ends at bit i.
 You can assume that bits j through i have enough space to hold m. That is, if
 `m = 10011`, you can assume that there are at least 5 bits between j and i.
 You would not, for example, have `j = 3` and `i = 2`, because m could not fully fit between bit 3
 and bit 2.
 */
extension Int {
    
    mutating func insert(_ insert: Int, i: Int, j: Int) {
        guard i < j else { return }
        
        let leftMask = ~0 << (j + 1)
        let rightMask = (1 << i) - 1
        let clearMask = leftMask | rightMask
        self = self & clearMask
        self = self | insert << i
    }
}

var n = 1024
var m = 19
var i = 2
var j = 6
n.insert(m, i: 2, j: 6)

var nString = String(n, radix: 2)
var mString = String(m, radix: 2)
var endIndex = nString.index(nString.endIndex, offsetBy: -i)
var startIndex = nString.index(endIndex, offsetBy: -mString.count)
assert(nString[startIndex..<endIndex] == mString)


n = 103217
m = 13
i = 4
j = 12
n.insert(m, i: 4, j: 12)

nString = String(n, radix: 2)
mString = String(m, radix: 2)
endIndex = nString.index(nString.endIndex, offsetBy: -i)
startIndex = nString.index(endIndex, offsetBy: -mString.count)
assert(nString[startIndex..<endIndex] == mString)

