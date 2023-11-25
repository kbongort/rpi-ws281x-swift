import rpi_ws281x

public struct Ws281xError: Error {
  let code: ws2811_return_t

  public var localizedDescription: String {
    switch code {
    case WS2811_SUCCESS: return "Success"
    case WS2811_ERROR_GENERIC: return "Generic failure"
    case WS2811_ERROR_OUT_OF_MEMORY: return "Out of memory"
    case WS2811_ERROR_HW_NOT_SUPPORTED: return "Hardware revision is not supported"
    case WS2811_ERROR_MEM_LOCK: return "Memory lock failed"
    case WS2811_ERROR_MMAP: return "mmap() failed"
    case WS2811_ERROR_MAP_REGISTERS: return "Unable to map registers into userspace"
    case WS2811_ERROR_GPIO_INIT: return "Unable to initialize GPIO"
    case WS2811_ERROR_PWM_SETUP: return "Unable to initialize PWM"
    case WS2811_ERROR_MAILBOX_DEVICE: return "Failed to create mailbox device"
    case WS2811_ERROR_DMA: return "DMA error"
    case WS2811_ERROR_ILLEGAL_GPIO: return "Selected GPIO not possible"
    case WS2811_ERROR_PCM_SETUP: return "Unable to initialize PCM"
    case WS2811_ERROR_SPI_SETUP: return "Unable to initialize SPI"
    case WS2811_ERROR_SPI_TRANSFER: return "SPI transfer error"
    default: return "Unknown"
    }
  }

}
