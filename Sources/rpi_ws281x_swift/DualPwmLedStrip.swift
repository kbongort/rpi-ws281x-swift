/**
 * DualPwmLedStrip can control two LED strings at once with dual-channel PWM.
 */
class DualPwmLedStrip: Ws2811 {

  /** GPIO pins for PWM channel 0. */
  public enum Pwm0Gpio: Int32  {
    case gpio12 = 12
    case gpio18 = 18
  }

  /** GPIO pins for PWM channel 1. */
  public enum Pwm1Gpio: Int32  {
    case gpio13 = 13
    case gpio19 = 19
  }

  public init(_ channel0: Channel<Pwm0Gpio>,
              _ channel1: Channel<Pwm1Gpio>,
              options: Ws2811Options = Ws2811Options()) throws {
    try super.init(channel0: channel0, channel1: channel1, options: options)
  }

  /** Renders colors to the LED strips. */
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

extension DualPwmLedStrip.Pwm0Gpio: GpioNum {
  public var number: Int32 { self.rawValue }
}

extension DualPwmLedStrip.Pwm1Gpio: GpioNum {
  public var number: Int32 { self.rawValue }
}
