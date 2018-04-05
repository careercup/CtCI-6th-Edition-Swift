/*:
 1.2 Determine if a string is a permutation of another
 */

import Foundation

// case and punctuation sensitive
extension String {
    
    func isPermutation(s: String) -> Bool {
        return characterCounts() == s.characterCounts()
    }

    func isPermutationWithCountedSet(s: String) -> Bool {
        let countedSet = NSCountedSet()
        for ch in self {
            countedSet.add(ch)
        }

        var isPermutation = true
        for ch in s {
            if !countedSet.contains(ch) {
                isPermutation = false
                break
            }
            countedSet.remove(ch)
        }

        return isPermutation
    }

}

extension String {
    
    func characterCounts() -> [Character: Int] {
        var characterCounts = [Character: Int]()
        self.forEach { c in
            characterCounts[c] = (characterCounts[c] ?? 0) + 1
        }
        return characterCounts
    }
}

"elvis".isPermutationWithCountedSet(s: "lives")
"elvis".isPermutationWithCountedSet(s: "elvis")
"elvis".isPermutation(s: "lives")
"elvis".isPermutation(s: "elvis")
