import rpi_ws281x

// Standard GPIO numbers for each hardware control mechanism.
public class GpioNum {
  public class Pwm0 {
    public static let gpio12 = 12
    public static let gpio18 = 18
    public static let gpio40 = 40
    public static let gpio52 = 52
  }
  public class Pwm1 {
    public static let gpio13 = 13
    public static let gpio19 = 19
    public static let gpio41 = 41
    public static let gpio53 = 53
  }
  public class Pcm {
    public static let gpio21 = 21
    public static let gpio31 = 31
  }
  public class Spi {
    public static let gpio10 = 10
    public static let gpio38 = 38
  }
}

public enum LedStripType: Int32 {
  case ws2811_RGB = 0x00100800
  case ws2811_RBG = 0x00100008
  case ws2811_GRB = 0x00081000
  case ws2811_GBR = 0x00080010
  case ws2811_BRG = 0x00001008
  case ws2811_BGR = 0x00000810

  case sk6812_RGBW = 0x18100800
  case sk6812_RBGW = 0x18100008
  case sk6812_GRBW = 0x18081000
  case sk6812_GBRW = 0x18080010
  case sk6812_BRGW = 0x18001008
  case sk6812_BGRW = 0x18000810
}

public struct Channel {
  let gpioNum: Int
  let ledCount: Int
  let stripType: LedStripType
  let invert: Bool
  let brightness: UInt8

  public init(gpioNum: Int, ledCount: Int, stripType: LedStripType, invert: Bool = false, brightness: UInt8 = 255) {
    self.gpioNum = gpioNum
    self.ledCount = ledCount
    self.stripType = stripType
    self.invert = invert
    self.brightness = brightness
  }

  func cStructValue() -> ws2811_channel_t {
    var channel = ws2811_channel_t()
    channel.gpionum = Int32(gpioNum)
    channel.invert = invert ? 1 : 0
    channel.count = Int32(ledCount)
    channel.strip_type = stripType.rawValue
    channel.brightness = brightness
    return channel
  }
}

