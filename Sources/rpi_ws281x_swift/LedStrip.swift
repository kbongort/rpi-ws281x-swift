import Foundation

/**
 * LedStrip controls a single strip of LEDs.
 */
public class LedStrip: Ws2811 {

  public enum Gpio: Int32 {
    /// SPI
    case gpio10 = 10

    /// PWM channel 0
    case gpio12 = 12
    case gpio18 = 18

    /// PCM
    case gpio21 = 21
    case gpio31 = 32
  }

  public init(_ channel: Channel<Gpio>, options: Ws2811Options = Ws2811Options()) throws {
    try super.init(channel0: channel, channel1: nil as Channel<Int>?, options: options)
  }

  public func render(colors: [PackedColor]) throws {
    try renderWithCallback { channel0, channel1 in
      guard let channel = channel0 ?? channel1 else {
        return
      }
      for i in 0..<min(channel.count, colors.count) {
        channel.data[i] = colors[i];
      }
    }
  }
}

extension LedStrip.Gpio: GpioNum {
  public var number: Int32 {
    return self.rawValue
  }
}
