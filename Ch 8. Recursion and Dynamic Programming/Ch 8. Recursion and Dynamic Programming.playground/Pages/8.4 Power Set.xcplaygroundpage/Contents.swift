import Foundation

/*:
 8.4 Power Set: return the set of all subsets of a set.
 */

extension Set {
  
  var allSubsets: Set<Set<Element>> {
    var allSubsets = Set<Set<Element>>([Set<Element>()])
    forEach { e in
      for subset in allSubsets {
        var setToAdd = subset
        setToAdd.insert(e)
        allSubsets.insert(setToAdd)
      }
    }
    return allSubsets
  }
}

var superSet = Set(["a", "b", "c", "d"])
var allSubsets = superSet.allSubsets
assert(allSubsets.count == 2.pow(superSet.count))
allSubsets.forEach { e in
  assert(e.isSubset(of: superSet))
}

