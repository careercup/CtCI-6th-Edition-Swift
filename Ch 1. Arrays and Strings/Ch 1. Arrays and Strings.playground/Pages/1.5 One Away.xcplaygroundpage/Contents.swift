/*:
 1.5 There are three types of characeter edits on strings: insert, replace, or delete. 
    Write a function to return if one string is 0 or 1 edit away from the other
 */
extension String {
    
    func zeroOrOneEditAway(from s: String) -> Bool {
        let (shorter, longer) = count < s.count ? (self, s) : (s, self)
        for (i, charShorter) in shorter.indicesElements() {
            let charLonger = longer[i]
            guard charShorter != charLonger else { continue }
            var s2 = shorter
            if shorter.count == longer.count {
                s2.replaceAtIndex(i: i, c: longer[i])
                return s2 == longer
            }
            s2.insert(charLonger, at: i)
            return s2 == longer
        }
        return longer.count - shorter.count <= 1
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

