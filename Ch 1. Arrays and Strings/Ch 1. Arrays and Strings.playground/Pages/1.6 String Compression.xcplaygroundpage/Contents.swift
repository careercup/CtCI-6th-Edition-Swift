/*: 
 1.6 Implement basic string compression using the counts of repeated characters. 
 If the compressed string is not smaller than the original, return the original.
 You can assume the string has only characters a-z \
  `aabcccccaaa -> a2b1c5a3`
 */

extension String {
    
    func compressedString() -> String {
        guard !isEmpty else { return self }
        var compressed = "\(self[startIndex])"
        var compressions = 1
        for char in dropFirst() {
            let p = compressed.last
            if char == p {
                compressions += 1
                continue
            }
            compressed += "\(compressions)" + "\(char)"
            compressions = 1
        }
        if compressions > 1 {
            compressed += "\(compressions)"
        }
        return compressed.count < count ? compressed : self
    }
}

var s = "aabcccccaaa"
let compressed = s.compressedString()
assert(compressed == "a2b1c5a3", "\(compressed) != a2b1c5a3")
