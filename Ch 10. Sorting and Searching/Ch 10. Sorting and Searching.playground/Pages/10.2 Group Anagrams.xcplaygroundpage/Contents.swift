import Foundation

/*:
 10.2 Sort an array of strings so that all of the anagrams are adjacent.
 */
extension RandomAccessCollection {
  
  var sortedByAnagram: [String]  {
    let strings = flatMap { e in (e as? String) }
    var anagramHashes = [Int: Int]()
    var sortedByAnagram = Array(repeating: [String](), count: numericCast(count))
    
    for (i, string) in strings.enumerated() {
      let hash = string.anagramHash
      let index = anagramHashes[hash] ?? i
      var sorted = sortedByAnagram[index]
      sorted.append(string)
      sortedByAnagram[index] = sorted
      anagramHashes[hash] = i
    }
    return sortedByAnagram.flatMap { $0 }
  }
}

extension String {
  
  var anagramHash: Int {
    let punctuation = NSMutableCharacterSet.punctuation()
    punctuation.formUnion(with: NSCharacterSet.whitespaces)
    
    return characters.reduce(0) { hash, char in
      let string = String(char).lowercased()
      guard let codeUnit = string.utf16.first else { return hash }
      if !punctuation.characterIsMember(codeUnit) {
        return string.hash + hash
      }
      return hash
    }
  }
}


var anagramsUnsorted = ["Dormitory", "Clothespins", "Lives", "The classroom", "Indicatory", "Twelve plus one", "Dirty Room", "Eleven plus two", "Dictionary", "Schoolmaster", "Elvis", "So let's pinch"]

let anagramsSorted = ["Dormitory", "Dirty Room", "Clothespins", "So let's pinch", "Lives", "Elvis", "The classroom", "Schoolmaster", "Indicatory", "Dictionary", "Twelve plus one", "Eleven plus two"]
print("\(anagramsUnsorted.sortedByAnagram)")

assert(anagramsUnsorted.sortedByAnagram == anagramsSorted)

