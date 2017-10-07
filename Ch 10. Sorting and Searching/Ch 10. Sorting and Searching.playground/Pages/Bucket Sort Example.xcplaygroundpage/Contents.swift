import Foundation

/*:
 Given a large array of Person objects sort them by age
 */

protocol PersonType {
  
  var age: Int { get }
  var name: String { get }
}

struct Person: PersonType, Equatable, CustomStringConvertible {
  
  let age: Int
  let name: String
  
  static func ==(lhs: Person, rhs: Person) -> Bool {
    return lhs.age == rhs.age
  }
  
  var description: String {
    return age.description
  }
}

extension Collection where Iterator.Element: PersonType {
  
  func bucketSortByAge() -> [Iterator.Element] {
    let maxAge = 100
    let emptyArray: [Iterator.Element] = []
    var buckets = Array<Array<Iterator.Element>>(repeating: emptyArray, count: maxAge)
    for person in self {
      var bucket = buckets[person.age]
      bucket.append(person)
      buckets[person.age] = bucket
    }
    return buckets.flatMap { $0 }
  }
}

var persons = [Person]()
let serialQueue = DispatchQueue(label: "")
let maxAge = 100

for _ in 0..<100 {
  let age = maxAge.arc4random_uniform()
  let person = Person(age: age, name: "")
  persons.append(person)
}

let bucketSorted = persons.bucketSortByAge()
let sorted = persons.sorted(by: { $0.age < $1.age })
assert(bucketSorted == sorted, "\(bucketSorted)\n\n\(sorted)")
