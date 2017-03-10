import Foundation

/*:
 8.8 Write a method to compute all permutations of a string of non-unique characters. The list of permutations should have no duplicates. 
 */

extension String {
  
  var allPermutations: [String] {
    var self_ = self
    var allPermutations = Set([String(self_.remove(at: startIndex))])
    
    for char in self_.characters {
      var permutations = Set<String>()
      for perm in allPermutations {
        for i in perm.characters.indices {
          var perm = perm
          perm.insert(char, at: i)
          guard !permutations.contains(perm) else { break }
          permutations.insert(perm)
        }
        let perm = perm.appending("\(char)")
        guard !permutations.contains(perm) else { break }
        permutations.insert(perm)
      }
      allPermutations = permutations
    }
    return Array(allPermutations)
  }
}

var permutations = "abca".allPermutations
permutations.sort()
assert(permutations == ["aabc", "aacb", "abac", "abca", "acab", "acba", "baac", "baca", "bcaa", "caab", "caba", "cbaa"])
