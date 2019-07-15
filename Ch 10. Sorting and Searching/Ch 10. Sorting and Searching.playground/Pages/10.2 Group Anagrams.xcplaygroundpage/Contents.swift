import Foundation

/*:
 10.2 Sort an array of strings so that all of the anagrams are adjacent.
 */
extension Array where Element == String {
    func sortedByAnagram() -> [String]  {
        func charCounts(_ s: String) -> [Character: Int] {
            let punctuation = NSMutableCharacterSet.punctuation()
            punctuation.formUnion(with: NSCharacterSet.whitespaces)
            return s.reduce(into: [Character: Int]()) { map, char in
                let lower = char.lowercased()
                guard let codeUnit = lower.utf16.first else { return }
                if !punctuation.characterIsMember(codeUnit) {
                    map[Character(lower), default: 0] += 1
                }
            }
        }
        var anagramHashes = [Int: Int]()
        let sortedByAnagram = enumerated().reduce(into: Array<[String]>(repeating: [String](), count: count)) { sortedByAnagram, entry in
            let hash = charCounts(entry.element).hashValue
            let index = anagramHashes[hash, default: entry.offset]
            var sorted = sortedByAnagram[index]
            sorted.append(entry.element)
            sortedByAnagram[index] = sorted
            anagramHashes[hash] = index
        }
        return sortedByAnagram.flatMap { $0 }
    }
}

var anagramsUnsorted = ["Dormitory", "Clothespins", "Lives", "The classroom", "Indicatory", "Twelve plus one", "Dirty Room", "Eleven plus two", "Dictionary", "Schoolmaster", "Elvis", "So let's pinch"]

let anagramsSorted = ["Dormitory", "Dirty Room", "Clothespins", "So let's pinch", "Lives", "Elvis", "The classroom", "Schoolmaster", "Indicatory", "Dictionary", "Twelve plus one", "Eleven plus two"]

let sortedByAnagram = anagramsUnsorted.sortedByAnagram()
assert(sortedByAnagram == anagramsSorted, "\(sortedByAnagram)")
