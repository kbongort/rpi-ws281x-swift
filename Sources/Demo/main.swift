import Foundation
import rpi_ws281x_swift

var onSigint: () -> Void = {}

// Ignore SIGINT default handling to prevent immediate termination.
signal(SIGINT, SIG_IGN)

// Add SIGINT handler that fades the lights to black then exits.
let sigintSrc = DispatchSource.makeSignalSource(signal: SIGINT, queue: .main)
sigintSrc.setEventHandler {
  onSigint()
  exit(0)
}
sigintSrc.resume()


let LED_COUNT = 10
let GPIO_NUM = GpioNum.Pwm0.gpio18

let BLACK_COLOR: PackedColor = 0;

func main() {
  do {
    let channel = Channel(gpioNum: GPIO_NUM, ledCount: LED_COUNT, stripType: .ws2811_RBG)
    let ledString = try LedString(channel0: channel)

    print("Running PWM on GPIO \(GPIO_NUM)")

    let startDate = Date()

    let timer = Timer.scheduledTimer(withTimeInterval:1.0/30, repeats: true) { _ in
      let t = Date().timeIntervalSince(startDate)
      let hue = Float((t / 10).truncatingRemainder(dividingBy: 1))
      let c = Color(hue: hue, saturation: 1, value: 1)

      let colorValue = PackedColor.fromRgb(red: c.red, green: c.green, blue: c.blue)

      ledString.render(Array(repeating: colorValue, count: LED_COUNT))
    }

    onSigint = {
      timer.invalidate()
      ledString.render(Array(repeating: BLACK_COLOR, count: LED_COUNT))
    }

  } catch {
    print("Error initializing GPIO: \(error)")
  }

  RunLoop.main.run()
}

main()
