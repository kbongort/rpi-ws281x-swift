//
//  File.swift
//  
//
//  Created by Kenneth Bongort on 11/25/23.
//

import Foundation

// Color packed as 0xWWRRGGBB
public typealias PackedColor = UInt32

extension PackedColor {

  public static func fromRgb(red: UInt8, green: UInt8, blue: UInt8) -> PackedColor {
    fromWrgb(white: 0, red: red, green: green, blue: blue)
  }

  public static func fromRgb(red: Float, green: Float, blue: Float) -> PackedColor {
    fromWrgb(white: 0, red: red, green: green, blue: blue)
  }

  public static func fromWrgb(white: UInt8, red: UInt8, green: UInt8, blue: UInt8) -> PackedColor {
    UInt32(white) << 24 | UInt32(red) << 16 | UInt32(green) << 8 | UInt32(blue)
  }

  public static func fromWrgb(white: Float, red: Float, green: Float, blue: Float) -> PackedColor {
    fromWrgb(white: UInt8(white * 255), red: UInt8(red * 255), green: UInt8(green * 255), blue: UInt8(blue * 255))
  }
}

public struct PackedColorArray {
  let data: UnsafeMutablePointer<PackedColor>
  let count: Int;
}
