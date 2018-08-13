/*:
 1.1 Determine if a string has all unique characters. What if you can't use additional data structures?
 */
extension String {
    
    func hasUniqueCharacters() -> Bool {
        if self.count < 1 {
            return true
        }
        var uniqueCharacters = Set<Character>()
        for c in self {
            guard !uniqueCharacters.contains(c) else { return false }
            uniqueCharacters.insert(c)
        }
        return true
    }
    
    func hasUniqueCharactersWithoutAdditionalDataStructs() -> Bool {
        if self.count < 1 {
            return true
        }
        if let _ = characters.sorted().successiveElements (where: { $0 == $1 }) {
            return false
        }
        return true
    }
}

let unique = "abc"
assert(unique.hasUniqueCharacters())
let dup = "abca"

assert(!dup.hasUniqueCharactersWithoutAdditionalDataStructs())



