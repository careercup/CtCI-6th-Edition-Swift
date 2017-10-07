import Foundation


public extension FixedWidthInteger  {
    
    var bitsSetCount: Int {
        var bitsSetCount = 0
        let selfInt: Int = numericCast(self)
        for i in 0..<64 {
            let mask = 1 << i
            if selfInt & mask == mask {
                bitsSetCount += 1
            }
        }
        return bitsSetCount
    }
}

public extension Int {
    
    func setBit(i: Int) -> Int {
        return self | 1 << i
    }
    
    func clearBit(i: Int) -> Int {
        return self & ~(1 << i)
    }
}

extension FixedWidthInteger where Stride: SignedInteger {
    
    var twosComplement: Int {
        guard self != 0 else { return 0 }
        let absv: Int = abs(distance(to: 0))
        let msbPosition = self.msbPosition + 1
        let complement = 2.pow(msbPosition) - absv
        let mask = ~0 << msbPosition
        return complement | mask
    }
    
    var msbPosition: Int {
        var absv: Int = abs(distance(to: 0))
        var position = 0
        var i = 0
        while absv > 0 {
            if absv & 1 == 1 {
                position = i + 1
            }
            i += 1
            absv >>= 1
        }
        return position
    }
    
    var twosComplement2: Int {
        guard self != 0 else { return 0 }
        let selfInt: Int = distance(to: 0)
        let lsbPosition = absv().lsbPosition
        let mask = ~0 << (lsbPosition - 1)
        let complement = ~selfInt & mask
        return complement | 1 << (lsbPosition - 1)
    }
    
    var lsbPosition: Int {
        var absv: Int = abs(distance(to: 0))
        var i = 0
        while absv > 0 {
            if absv & 1 == 1 {
                return i + 1
            }
            i += 1
            absv >>= 1
        }
        return 0
    }
}

public extension FixedWidthInteger {
    
    func absv() -> Self {
        let zero: Self = self - self
        return self < zero ? zero - self : self
    }
}

public extension FixedWidthInteger where Stride: SignedInteger {
    
    func binaryString() -> String {
        let selfInt: Int = distance(to: 0)
        var string = ""
        for i in 0..<64 {
            let mask = 1 << i
            let bit = selfInt & mask == mask ? "1" : "0"
            string = bit + string
        }
        return string
    }
}


public extension FixedWidthInteger {
    
    func asBinaryString() -> String {
        return String(self, radix: 2)
    }
}


