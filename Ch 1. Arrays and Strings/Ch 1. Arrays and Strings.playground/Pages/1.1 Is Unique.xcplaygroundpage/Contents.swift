/*:
 1.1 Determine if a string has all unique characters. What if you can't use additional data structures?
 Algoritms below works with unicodes.
 */
extension String {

    /// Check if string consists of only unique characters.
    /// * It's time complexity is O(N) and storage is O(N)
    func hasUniqueCharacters() -> Bool {
        var isUnique = true
        var characters = Set<Character>()
        for character in self {
            guard !characters.contains(character) else {
                isUnique = false
                break
            }
            characters.insert(character)
        }
        return isUnique
    }

}

extension String {

    /// Check if string consists of only unique characters.
    /// * It's time complexity is O(N*logN) and storage is O(1)
    func hasUniqueCharactersWithoutAdditionalDataStructs() -> Bool {
        if let _ = self.sorted().successiveElements (where: { $0 == $1 }) {
            return false
        }
        return true
    }


    /// Check if string consists of only unique characters.
    /// * The same limits and solution like in the book.
    /// * It's time complexity is O(N) and storage is O(1)
    func hasUniqueCharactersASCIIWithoutAdditionalDataStructs() -> Bool {
        var isUnique = true
        var checker: Int32 = 0
        guard let asciiValueOfA = Character("a").unicodeScalars.first?.value else { return false }
        for character in self.sorted() {
            // if character is not ascii then false
            guard let asciiValue = character.unicodeScalars.first?.value else {
                isUnique = false
                break
            }

            let numberInAlphabet = asciiValue - asciiValueOfA
            guard checker & (1 << numberInAlphabet) == 0 else {
                isUnique = false
                break
            }
            checker |= (1 << numberInAlphabet)
            print("\(String(checker, radix: 2))")
        }

        return isUnique
    }

}

// tests:
// Test string with unique characters. Expected result is true.
"abc".hasUniqueCharacters()
"abc".hasUniqueCharactersWithoutAdditionalDataStructs()
"abc".hasUniqueCharactersASCIIWithoutAdditionalDataStructs()

// Test string with repeate characters. Expected result is false.
"abca".hasUniqueCharacters()
"abca".hasUniqueCharactersWithoutAdditionalDataStructs()
"abca".hasUniqueCharactersASCIIWithoutAdditionalDataStructs()

