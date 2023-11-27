public protocol GpioNum {
  var number: Int32 { get }
}

/** Protocol for channel 0 GPIO numbers (PWM0, PCM, and SPI). */
public protocol Channel0Gpio: GpioNum {}
/** Protocol for channel 1 GPIO numbers (only PWM1). */
public protocol Channel1Gpio: GpioNum {}

/**
 * Gpio contains standard GPIO pin numbers for each output method.
 *
 * Use `Gpio.Custom` for a custom value.
 */
public struct Gpio {
  public enum Pwm0: Int32, Channel0Gpio {
    case gpio12 = 12
    case gpio18 = 18

    public var number: Int32 {
      self.rawValue
    }
  }

  public enum Pwm1: Int32, Channel1Gpio {
    case gpio13 = 12
    case gpio19 = 19

    public var number: Int32 {
      self.rawValue
    }
  }

  public enum Pcm: Int32, Channel0Gpio {
    case gpio21 = 21
    case gpio31 = 31

    public var number: Int32 {
      self.rawValue
    }
  }

  public enum Spi: Int32, Channel0Gpio {
    case gpio10 = 10

    public var number: Int32 {
      self.rawValue
    }
  }

  public struct Custom: Channel0Gpio, Channel1Gpio {
    public let number: Int32

    public init(number: Int32) {
      self.number = number
    }
  }
}
