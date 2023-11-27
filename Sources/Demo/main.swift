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
let GPIO_NUM = Gpio.Pwm0.gpio18

let BLACK_COLOR: PackedColor = 0;

func main() {
  do {
    let channel = Channel(gpio: Gpio.Pwm0.gpio18, ledCount: LED_COUNT, stripType: .ws2811_GRB)
    let ledString = try LedString(channel)

    print("Running PWM on GPIO \(GPIO_NUM)")

    let startDate = Date()

    let timer = Timer.scheduledTimer(withTimeInterval:1.0/30, repeats: true) { _ in
      let t = Date().timeIntervalSince(startDate)
      let hue = Float((t / 10).truncatingRemainder(dividingBy: 1))
      let c = Color(hue: hue, saturation: 1, value: 1)

      let colorValue = PackedColor.fromRgb(red: c.red, green: c.green, blue: c.blue)

      try? ledString.render(colors: Array(repeating: colorValue, count: LED_COUNT))
    }

    onSigint = {
      timer.invalidate()
      try? ledString.render(colors: Array(repeating: BLACK_COLOR, count: LED_COUNT))
      ledString.finish()
    }

  } catch {
    print("Error initializing GPIO: \(error)")
  }

  RunLoop.main.run()
}

main()
