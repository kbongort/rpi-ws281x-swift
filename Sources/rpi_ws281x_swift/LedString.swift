import Foundation

public class LedString: Ws2811 {

  public init(_ channel: Channel<some Channel0Gpio>, options: Ws2811Options = Ws2811Options()) throws {
    try super.init(channel0: channel, channel1: nil as Channel<Gpio.Custom>?, options: options)
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
