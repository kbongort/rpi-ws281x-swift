import rpi_ws281x

public enum LedStripType {
  case ws2811_RGB
  case ws2811_RBG
  case ws2811_GRB
  case ws2811_GBR
  case ws2811_BRG
  case ws2811_BGR

  case sk6812_RGBW
  case sk6812_RBGW
  case sk6812_GRBW
  case sk6812_GBRW
  case sk6812_BRGW
  case sk6812_BGRW

  public var value: Int32 {
    switch self {
    case .ws2811_RGB: return WS2811_STRIP_RGB
    case .ws2811_RBG: return WS2811_STRIP_RBG
    case .ws2811_GRB: return WS2811_STRIP_GRB
    case .ws2811_GBR: return WS2811_STRIP_GBR
    case .ws2811_BRG: return WS2811_STRIP_BRG
    case .ws2811_BGR: return WS2811_STRIP_BGR

    case .sk6812_RGBW: return SK6812_STRIP_RGBW
    case .sk6812_RBGW: return SK6812_STRIP_RBGW
    case .sk6812_GRBW: return SK6812_STRIP_GRBW
    case .sk6812_GBRW: return SK6812_STRIP_GBRW
    case .sk6812_BRGW: return SK6812_STRIP_BRGW
    case .sk6812_BGRW: return SK6812_STRIP_BGRW
    }
  }
}
