/*:
 1.1 Determine if a string has all unique characters. What if you can't use additional data structures?
 */
extension String {
    
    func hasUniqueCharacters() -> Bool {
        var uniqueCharacters = Set<Character>()
        for char in self {
            guard !uniqueCharacters.contains(char) else { return false }
            uniqueCharacters.insert(char)
        }
        return true
    }
    
    func hasUniqueCharactersWithoutAdditionalDataStructs() -> Bool {
        let repeatedElements = sorted().successiveElements (where: { $0 == $1 })
        return repeatedElements == nil ? true : false
    }
}

let unique = "abc"
assert(unique.hasUniqueCharacters())
let dup = "abca"

assert(!dup.hasUniqueCharactersWithoutAdditionalDataStructs())



