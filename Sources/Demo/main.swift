import Foundation
import rpi_ws281x_swift
import rpi_ws281x

let GPIO_PIN = LedStrip.Gpio.gpio18
let LED_COUNT = 10

let BLACK_COLOR: PackedColor = .fromRgb(red: UInt8(0), green: 0, blue: 0);

func main() {
  do {
    let ledString = try LedStrip(Channel(gpio: GPIO_PIN, ledCount: LED_COUNT, stripType: .ws2811_GRB))
    print("Running PWM on GPIO \(GPIO_PIN)")

    let startDate = Date()
    let timer = Timer.scheduledTimer(withTimeInterval:1.0/30, repeats: true) { _ in
      let t = Date().timeIntervalSince(startDate)
      let hue = Float((t / 10).truncatingRemainder(dividingBy: 1))
      let c = Color(hue: hue, saturation: 1, value: 1)

      let colorValue = PackedColor.fromRgb(red: c.red, green: c.green, blue: c.blue)

      try? ledString.render(colors: Array(repeating: colorValue, count: LED_COUNT))
    }

    handleSignals([SIGINT, SIGTERM]) {
      timer.invalidate()
      try? ledString.render(colors: Array(repeating: BLACK_COLOR, count: LED_COUNT))
      ledString.finish()
      exit(0)
    }
  } catch {
    print("Error initializing GPIO: \(error)")
  }

  RunLoop.main.run()
}

main()
