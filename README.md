# rpi_ws281x_swift

Swift bindings for the [rpi_ws281x](https://github.com/jgarff/rpi_ws281x) library.

### Try it out
```
git clone https://github.com/kbongort/rpi-ws281x-swift
cd rpi-ws281x-swift
sudo swift run
```

### Use it in your project

Add this library as a dependency to your target:
```
// swift-tools-version: 5.4

import PackageDescription

let package = Package(
    name: "YourPackageName",
    dependencies: [
        .package(url: "https://github.com/kbongort/rpi-ws281x-swift.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "YourTargetName",
            dependencies: [
                .product(name: "rpi_ws281x_swift", package: "rpi-ws281x-swift"),
            ])
    ]
)
```

Basic usage (see [main.swift](https://github.com/kbongort/rpi-ws281x-swift/blob/main/Sources/Demo/main.swift) for a complete example):
```
// Initialize
let GPIO_NUM = GpioNum.Pwm0.gpio18  // GPIO 18 is pin 12 on Raspberry Pi 4
let channel = Channel(gpioNum: GPIO_NUM, ledCount: 10, stripType: .ws2811_RBG)
let ledString = try LedString(channel0: channel)

// Call .render() to update LEDs
ledString.render(colors /* A [UInt32] of WRGB packed colors */)

// Clean up when done
ledString.finish()

```
