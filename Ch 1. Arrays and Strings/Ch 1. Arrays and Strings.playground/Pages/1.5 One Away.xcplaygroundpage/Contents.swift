/*:
 1.5 There are three types of characeter edits on strings: insert, replace, or delete. 
    Write a function to return if one string is 0 or 1 edit away from the other
 */
extension String {
    
    func zeroOrOneEditAway(from s: String) -> Bool {
        let (shorter, longer) = characters.count < s.characters.count ? (self, s) : (s, self)
        for (i, c) in shorter.characters.enumeratedIndices() {
            let c2 = longer.characters[i]
            guard c != c2 else { continue }
            var s2 = shorter
            if shorter.characters.count == longer.characters.count {
                s2.replaceAtIndex(i: i, c: longer.characters[i])
                return s2 == longer
            }
            s2.insert(c2, at: i)
            return s2 == longer
        }
        return longer.characters.count - shorter.characters.count <= 1
    }
}

var s1 = "pale"
var s2 = "ple"

assert(s2.zeroOrOneEditAway(from: s1))

s1 = "pale"
s2 = "pale"

assert(s2.zeroOrOneEditAway(from: s1))

s1 = "pale"
s2 = "pales"

assert(s2.zeroOrOneEditAway(from: s1))


s1 = "pale"
s2 = "bake"
 
assert(!s2.zeroOrOneEditAway(from: s1))

