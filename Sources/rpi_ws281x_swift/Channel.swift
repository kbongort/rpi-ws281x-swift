import rpi_ws281x

/**
 * A channel contains configuration for an LED string running on a particular GPIO.
 */
public struct Channel<T: GpioNum> {
  /**
   * The underlying `ws2811_channel_t` struct for this channel.
   * May be used for advanced configuration.
   */
  public var ws2811Channel: ws2811_channel_t

  /**
   * Initializes the channel configuration.
   *
   * - Parameter gpio: The GPIO pin number, as a GpioNum. Standard GPIO numbers
   *                   are in Gpio, e.g. `Gpio.Pwm0.gpio18`.
   * - Parameter ledCount: The number of LEDs in the string.
   * - Parameter stripType: The LED strip type.
   */
  public init(gpio: T, ledCount: Int, stripType: LedStripType) {
    var channel = ws2811_channel_t()
    channel.gpionum = gpio.number
    channel.count = Int32(ledCount)
    channel.strip_type = stripType.value
    channel.brightness = 255
    self.ws2811Channel = channel
  }
}
