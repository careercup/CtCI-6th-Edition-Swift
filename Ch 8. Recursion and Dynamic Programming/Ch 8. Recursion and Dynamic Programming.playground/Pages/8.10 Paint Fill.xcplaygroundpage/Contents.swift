import Foundation

/*:
 8.10 Implement the paint fill function in an image editor. Given a matrix of colors, paint them to the new color.
 */

protocol ColorProtocol {
  var color: Color { get set }
}

enum Color: ColorProtocol, CustomStringConvertible {
  
  case Green
  case Blue
  case Red
  
  var  color: Color {
    get {
      return self
    }
    set {
      self = newValue
    }
  }
  
  var description: String {
    switch self {
    case .Green: return "green"
    case .Red: return "red"
    case .Blue: return "blue"
    }
  }
}

extension MutableCollection where Iterator.Element: MutableCollection, Iterator.Element.Iterator.Element: ColorProtocol, Iterator.Element.Index == Index {
  
  mutating func colorSurroundingElements(x: Index, y: Index, oldColor: Color, newColor: Color) {
    let xIsInRange = distance(from: startIndex, to: x) >= 0 && distance(from: x, to: endIndex) > 0
    guard xIsInRange else { return }
    let yIsInRange = distance(from: self[x].startIndex, to: y) >= 0 && distance(from: y, to: self[x].endIndex) > 0
    guard yIsInRange else { return }
    
    var candidate = self[x][y]
    guard case candidate.color = oldColor else { return }
    
    candidate.color = newColor
    self[x][y] = candidate
    
    colorSurroundingElements(x: index(x, offsetBy: -1), y: y, oldColor: oldColor, newColor: newColor)
    colorSurroundingElements(x: index(after: x), y: y, oldColor: oldColor, newColor: newColor)
    colorSurroundingElements(x: x, y: index(y, offsetBy: -1), oldColor: oldColor, newColor: newColor)
    colorSurroundingElements(x: x, y: index(after: y), oldColor: oldColor, newColor: newColor)
  }
}

var r1: [Color] = [.Green, .Green, .Green, .Red]
var r2: [Color] = [.Green, .Green, .Green, .Red]
var r3: [Color] = [.Green, .Green, .Green, .Red]
var r4: [Color] = [.Green, .Green, .Green, .Red]

var colors = [r1,r2,r3, r4]
colors.colorSurroundingElements(x: 1,y: 1, oldColor: .Green, newColor: .Blue)
colors.forEach { row in
  assert(row[0..<colors.index(before: colors.endIndex)] == [.Blue, .Blue, .Blue])
  assert(row.last! == .Red)
}
