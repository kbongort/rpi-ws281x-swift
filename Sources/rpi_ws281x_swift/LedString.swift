import rpi_ws281x

public class LedString {
  private var ws2811 = ws2811_t()
  private var didFinish = false

  public init(channel0: Channel? = nil, channel1: Channel? = nil) throws {
    ws2811.freq = UInt32(WS2811_TARGET_FREQ)
    ws2811.dmanum = 10
    if let channel0 {
      ws2811.channel.0 = channel0.cStructValue()
    }
    if let channel1 {
      ws2811.channel.1 = channel1.cStructValue()
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

  public func render(_ channel0: [PackedColor] = [], _ channel1: [PackedColor] = []) {
    guard !didFinish else { return }

    renderWithCallback { channel0Values, channel1Values in
      if let channel0Values {
        for i in 0..<min(channel0Values.count, channel0.count) {
          channel0Values.data[i] = channel0[i];
        }
      }

      if let channel1Values {
        for i in 0..<min(channel1Values.count, channel1.count) {
          channel1Values.data[i] = channel1[i];
        }
      }
    }
  }

  // Each callback receives a mutable array to write color values to and a count.
  public func renderWithCallback(_ callback: (PackedColorArray?, PackedColorArray?) -> Void) {
    guard !didFinish else { return }

    let channel0Values = ws2811.channel.0.leds != nil ? PackedColorArray(data: ws2811.channel.0.leds, count:  Int(ws2811.channel.0.count)) : nil
    let channel1Values = ws2811.channel.1.leds != nil ? PackedColorArray(data: ws2811.channel.1.leds, count:  Int(ws2811.channel.1.count)) : nil
    callback(channel0Values, channel1Values);

#if os(Linux)
    ws2811_render(&ws2811)
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

