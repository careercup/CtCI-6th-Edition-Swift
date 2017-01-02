import Foundation


public extension Int {
    
    func setBit(i: Int) -> Int {
        return self | 1 << i
    }
    
    func clearBit(i: Int) -> Int {
        return self & ~(1 << i)
    }
}

public extension Integer where Stride: SignedInteger {
    
    var bitsSetCount: Int {
        var bitsSetCount = 0
        let selfInt: Int = numericCast(Self.allZeros.distance(to: self))
        for i in 0..<64 {
            let mask = 1 << i
            if selfInt & mask == mask {
                bitsSetCount += 1
            }
        }
        return bitsSetCount
    }
}

extension Integer where Stride: SignedInteger {
    
    var factorial: Self {
        guard self > 1 else { return 1 }
        let selfInt: Int = numericCast(Self.allZeros.distance(to: self))
        let range = 1...selfInt
        return range.reduce(1, *)
    }
}

extension Set {
    
    func combinations(n: Int, k: Int) -> Int {
        guard n >= 0 && k <= n else { return 0 }
        let left = (n - k + 1)...n
        let right = 1...k
        let pairs = zip(left, right)
        return pairs.reduce(1) { $0 * $1.0 / $1.1 }
    }

    func combinations(k: Int) -> Int {
        guard k <= count else { return 0 }
        return count.factorial / (k.factorial * (count - k).factorial)
    }
}

extension Integer where Stride: SignedInteger {
    
    var twosComplement: Int {
        guard self != 0 else { return 0 }
        let absv: Int = numericCast(abs(Self.allZeros.distance(to: self)))
        let msbPosition = self.msbPosition + 1
        let complement = 2.pow(msbPosition) - absv
        let mask = ~0 << msbPosition
        return complement | mask
    }
    
    var msbPosition: Int {
        var absv: Int = numericCast(abs(Self.allZeros.distance(to: self)))
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
        let selfInt: Int = numericCast(Self.allZeros.distance(to: self))
        let lsbPosition = absv.lsbPosition
        let mask = ~0 << (lsbPosition - 1)
        let complement = ~selfInt & mask
        return complement | 1 << (lsbPosition - 1)
    }
    
    var lsbPosition: Int {
        var absv: Int = numericCast(abs(Self.allZeros.distance(to: self)))
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

public extension IntegerArithmetic {
    
    var absv: Self {
        let zero: Self = self - self
        return self < zero ? zero - self : self
    }
}

public extension Integer where Stride: SignedInteger {
    
    var binaryString: String {
        let selfInt: Int = numericCast(Self.allZeros.distance(to: self))
        var string = ""
        for i in 0..<64 {
            let mask = 1 << i
            let bit = selfInt & mask == mask ? "1" : "0"
            string = bit + string
        }
        return string
    }
}


public extension SignedInteger {
    
    var asBinaryString: String {
        return String(self, radix: 2)
    }
}

public extension UnsignedInteger {
    
    var asBinaryString: String {
        return String(self, radix: 2)
    }
}
