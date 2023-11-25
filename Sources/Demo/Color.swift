import Foundation

extension Float {
  func clamp(l: Float, h: Float) -> Float {
    return min(h, max(l, self))
  }
}

struct Color {
  var red: Float
  var green: Float
  var blue: Float

  static let black = Color(red: 0, green: 0, blue: 0)
  static let white = Color(red: 1, green: 1, blue: 1)
  static let red = Color(red: 1, green: 0, blue: 0)
  static let blue = Color(red: 0, green: 0, blue: 1)
  static let green = Color(red: 0, green: 1, blue: 0)

  func ints() -> (green: UInt8, red: UInt8, blue: UInt8) {
    (UInt8(green * 255), UInt8(red * 255), UInt8(blue * 255))
  }

  static func * (left: Color, right: Float) -> Color {
    let val = right.clamp(l: 0, h: 1);
    return Color(red: left.red * val, green: left.green * val, blue: left.blue * val)
  }

  static func * (left: Color, right: Double) -> Color {
    return left * Float(right)
  }

  init(red: Float, green: Float, blue: Float) {
    self.red = red
    self.green = green
    self.blue = blue
  }

  init(hue: Float, saturation S: Float, value V: Float) {
    // Easier to reason about hue in terms of degrees.
    let H: Float = hue.clamp(l: 0, h: 1) * 360

    let C = V * S

    let X = C * (1 - abs((H / 60).truncatingRemainder(dividingBy: 2) - 1))

    let m = V - C

    let (Rp, Gp, Bp): (Float, Float, Float) = {
      switch H {
      case 0..<60:
        return (C, X, 0)
      case 60..<120:
        return (X, C, 0)
      case 120..<180:
        return (0, C, X)
      case 180..<240:
        return (0, X, C)
      case 240..<300:
        return (X, 0, C)
      default:
        return (C, 0, X)
      }
    }()

    red = Rp + m
    green = Gp + m
    blue = Bp + m
  }
}
