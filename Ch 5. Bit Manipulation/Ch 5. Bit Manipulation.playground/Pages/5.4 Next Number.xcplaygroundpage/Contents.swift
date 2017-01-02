import Foundation

/*:
 Given a positive Int, print the next smallest and the next largest number that have the same
 number of 1 bits in their binary representation.
 */

extension UInt {
    
    var nextSmallerAndLargerIntsWithSameCountOfBitsSetTo1: (smaller: UInt?, larger: UInt?) {
        return (nextSmaller, nextLarger)
    }
    
    private var nextLarger: UInt? {
        guard self > 0 && self < UInt.max else { return nil }
        
        var zerosCount: UInt = 0
        var onesCount: UInt = 0
        var selfCopy = self
        while selfCopy & 1 == 0 {
            zerosCount += 1
            selfCopy >>= 1
        }
        while selfCopy & 1 == 1 {
            onesCount += 1
            selfCopy >>= 1
        }
        if zerosCount + onesCount >= 63 {
            return nil
        }
        selfCopy = self & ~0 << (zerosCount + onesCount)
        selfCopy |= 1 << (onesCount - 1) - 1
        selfCopy |= 1 << (zerosCount + onesCount)
        return selfCopy
    }
    
    private var nextSmaller: UInt? {
        guard self > 0 else { return nil }
        
        var zerosCount: UInt = 0
        var onesCount: UInt = 0
        var selfCopy = self
        while selfCopy & 1 == 1 {
            onesCount += 1
            selfCopy >>= 1
        }
        guard selfCopy > 0 else { return nil }
        
        while selfCopy & 1 == 0 {
            zerosCount += 1
            selfCopy >>= 1
        }
        selfCopy = self & ~0 << (zerosCount + onesCount + 1)
        let mask = (1 << (onesCount + 1) - 1)
        selfCopy |= mask << (zerosCount - 1)
        return selfCopy
    }
}


for i: UInt in 13000..<14000 {
    
    let (smaller, larger) = i.nextSmallerAndLargerIntsWithSameCountOfBitsSetTo1
    let iBitCount = i.bitsSetCount
    
    if let smaller = smaller {
        let smallerBitCount = smaller.bitsSetCount
        assert(smaller < i, "i = \(i), smaller = \(smaller)", file: "")
        assert(smallerBitCount == iBitCount, "i = \(i), iBitCount = \(iBitCount), smaller = \(smaller) smallerBitCount = \(smallerBitCount)", file: "")
        var j = i - 1
        while j > smaller {
            let jBitCount = j.bitsSetCount
            assert(jBitCount != iBitCount, "\(jBitCount) == \(iBitCount) for \(j) \(i) \(smaller)", file: "")
            j -= 1
        }
    }
    else {
        var j = i - 1
        while j > 0  {
            let jBitCount = j.bitsSetCount
            assert(jBitCount != iBitCount, "i = \(i): \(j) is next smaller with \(jBitCount) one bits\n", file: "")
            j -= 1
        }
    }
    if let larger = larger {
        let largerBitCount = larger.bitsSetCount
        assert(larger > i, "i = \(i), larger = \(larger)", file: "")
        assert(largerBitCount == iBitCount, "i = \(i), iBitCount = \(iBitCount), larger = \(larger) largerBitCount = \(largerBitCount)", file: "")
        var j = i + 1
        while j < larger {
            let jBitCount = j.bitsSetCount
            assert(jBitCount != iBitCount, "\(jBitCount) == \(iBitCount) for \(j) \(i) \(larger)")
            j += 1
        }
    }
    else {
        var j = i + 1
        while j < UInt.max  {
            let jBitCount = j.bitsSetCount
            assert(jBitCount != iBitCount, "i = \(i): \(j) is next larger with \(jBitCount) one bits\n", file: "")
            j += 1
        }
    }
}

