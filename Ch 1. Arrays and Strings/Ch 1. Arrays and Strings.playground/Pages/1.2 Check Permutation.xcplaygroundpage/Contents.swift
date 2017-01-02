/*:
 1.2 Determine if a string is a permutation of another
 */

// case and punctuation sensitive
extension String {
    
    func isPermutation(s: String) -> Bool {
        return characterCounts() == s.characterCounts()
    }
}

extension String {
    
    func characterCounts() -> [Character: Int] {
        var characterCounts = [Character: Int]()
        characters.forEach { c in
            characterCounts[c] = (characterCounts[c] ?? 0) + 1
        }
        return characterCounts
    }
}

let s1 = "elvis"
let s2 = "lives"

assert(s2.isPermutation(s: s1))


