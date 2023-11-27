import rpi_ws281x

public struct Ws2811Options {
  public let dmaNumber: Int32
  public let frequency: UInt32
  public let renderWaitTime: UInt64

  public init(dmaNumber: Int32 = 10, frequency: UInt32 = UInt32(WS2811_TARGET_FREQ), renderWaitTime: UInt64 = 0) {
    self.dmaNumber = dmaNumber
    self.frequency = frequency
    self.renderWaitTime = renderWaitTime
  }
}

/**
 * Wrapper for the ws2811 API.
 */
public class Ws2811 {
  private(set) public var ws2811 = ws2811_t()

  private var didFinish = false

  convenience init(channel0: Channel<some Channel0Gpio>,
                   options: Ws2811Options = Ws2811Options()) throws {
    try self.init(channel0: channel0, channel1: nil as Channel<Gpio.Custom>?, options: options)
  }

  init(channel0: Channel<some Channel0Gpio>,
       channel1: Channel<some Channel1Gpio>? = nil,
       options: Ws2811Options = Ws2811Options()) throws {
    ws2811.dmanum = options.dmaNumber
    ws2811.freq = options.frequency
    ws2811.render_wait_time = options.renderWaitTime
    ws2811.channel.0 = channel0.ws2811Channel
    if let channel1 {
      ws2811.channel.1 = channel1.ws2811Channel
    }

#if os(Linux)
    let ret = ws2811_init(&ws2811)
    if ret != WS2811_SUCCESS {
      throw Ws281xError(code: ret)
    }
#endif
  }

  deinit {
    finish()
  }

  /**
   * Invokes a callback to populate color data, then renders.
   *
   * - Parameter callback: A callback that takes a PackedColorArray for each channel.
   *                       The callback should set the colors in the array for each channel in use.
   */
  func renderWithCallback(_ callback: (PackedColorArray?, PackedColorArray?) -> Void) throws {
    guard !didFinish else { return }

    let channel0Values = ws2811.channel.0.leds != nil ? PackedColorArray(data: ws2811.channel.0.leds, count:  Int(ws2811.channel.0.count)) : nil
    let channel1Values = ws2811.channel.1.leds != nil ? PackedColorArray(data: ws2811.channel.1.leds, count:  Int(ws2811.channel.1.count)) : nil
    callback(channel0Values, channel1Values);

    render()
  }

  func render() {
#if os(Linux)
    let ret = ws2811_render(&ws2811)
    if ret != WS2811_SUCCESS {
      throw Ws281xError(code: ret)
    }
#endif
  }

  func wait() {
#if os(Linux)
    let ret = ws2811_wait(&ws2811)
    if ret != WS2811_SUCCESS {
      throw Ws281xError(code: ret)
    }
#endif
  }

  public func finish() {
    guard !didFinish else { return }

#if os(Linux)
    ws2811_fini(&ws2811)
#endif
    didFinish = true
  }
}

