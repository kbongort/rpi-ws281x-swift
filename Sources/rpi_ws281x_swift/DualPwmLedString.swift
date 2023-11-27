class DualPwmLedString: Ws2811 {

  public init(_ channel0: Channel<Gpio.Pwm0>,
              _ channel1: Channel<Gpio.Pwm1>,
              options: Ws2811Options = Ws2811Options()) throws {
    try super.init(channel0: channel0, channel1: channel1, options: options)
  }

  public func render(channel0Colors: [PackedColor], channel1Colors: [PackedColor]) throws {
    try renderWithCallback { channel0, channel1 in
      if let channel0 {
        for i in 0..<min(channel0.count, channel0Colors.count) {
          channel0.data[i] = channel0Colors[i];
        }
      }
      if let channel1 {
        for i in 0..<min(channel1.count, channel1Colors.count) {
          channel1.data[i] = channel1Colors[i];
        }
      }
    }
  }
}
