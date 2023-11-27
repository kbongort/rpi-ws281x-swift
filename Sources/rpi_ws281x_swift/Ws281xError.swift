import rpi_ws281x

public struct Ws281xError: Error {
  public let code: ws2811_return_t

  public var localizedDescription: String {
#if os(Linux)
    if let chars = ws2811_get_return_t_str(code) {
      return String(cString: chars)
    }
#endif
    return "Unknown"
  }
}
