/*: 
 1.6 Implement basic string compression using the counts of repeated characters. 
 If the compressed string is not smaller than the original, return the original.
 You can assume the string has only characters a-z \
  `aabcccccaaa -> a2b1c5a3`
 */

extension String {
    
    func compressedString() -> String {
        guard !isEmpty else { return self }
        var s = "\(characters[startIndex])"
        var count = 1
        for c in characters.dropFirst() {
            let p = s.characters.last
            if c == p {
                count += 1
                continue
            }
            s += "\(count)" + "\(c)"
            count = 1
        }
        if count > 1 {
            s += "\(count)"
        }
        return s.characters.count < characters.count ? s : self
    }
}

var s = "aabcccccaaa"
assert(s.compressedString() == "a2b1c5a3")
"aaabb".compressedString()










