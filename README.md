# rpi_ws281x_swift

Swift bindings for the [rpi_ws281x](https://github.com/jgarff/rpi_ws281x) library.

### Overview

This package has two libraries. `rpi_ws281x_swift` provides a user-friendly Swifty interface, with native classes and enums. `rpi_ws281x` simply bridges the rpi_ws281x C headers into Swift.

The README for [rpi_ws281x](https://github.com/jgarff/rpi_ws281x) is recommended reading. It contains useful background information about using a Raspberry Pi to control an LED strip.

### Try it out

The demo program uses DMA on channel 10 to run PWM on GPIO 18, which corresponds to pin 12 on the Raspberry Pi's GPIO header. It must be run with `sudo` as it requires direct memory access.

```
git clone https://github.com/kbongort/rpi-ws281x-swift
cd rpi-ws281x-swift
swift build
sudo .build/debug/Demo
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

## Using `rpi_ws281x_swift`

The library has three classes for controlling LED strips to serve use cases from basic to advanced. `LedStrip` is a user-friendly class for controlling a single strip of LEDs. `DualPwmLedStrip` is a specialized class for controlling two strips of LEDs with PWM on two channels. Both inherit from `Ws2811`, which is a lightweight wrapper for the C API.

This library endeavors to provide simple, well-lit paths to working LEDs. It also provides the ability to "break glass" and use less common configurations.

For developer convenience, this library can be compiled and run on Mac, but
it will only make calls to the underlying C library on Linux.

#### LedStrip

Most use cases should be well served by `LedStrip`. It is initialized with a channel using a
GPIO number corresponding to one of the available output methods (SPI, PWM, or PCM).
Use it as follows:

```
import rpi_ws281x_swift

let ledStrip = try! LedStrip(Channel(gpio: .gpio18, ledCount: 10, stripType: .ws2811_GRB))

// Set LED colors
let colors = Array(repeating: 0x00FF0000 /* red */, count: 10)
try! ledStrip.render(colors)

// Later…
ledString.finish()
```

See [main.swift](https://github.com/kbongort/rpi-ws281x-swift/blob/main/Sources/Demo/main.swift) for a complete example.

#### DualPwmLedStrip

The `DualPwmLedStrip` class can control two LED strips with dual-channel
PWM. Usage is similar to LedStrip, but with two channels instead of one. Channels use GPIO numbers compatible with PWM on channels 0 and 1, respectively.

```
import rpi_ws281x_swift

let ledStrip = try! LedStrip(Channel(gpio: .gpio18, ledCount: 10, stripType: .ws2811_GRB),
                             Channel(gpio: .gpio13, ledCount: 10, stripType: .ws2811_GRB))

// Set LED colors
let channel0Colors = Array(repeating: 0x00FF0000 /* red */, count: 10)
let channel1Colors = Array(repeating: 0x0000FF00 /* green */, count: 10)
try! ledStrip.render(channel0Colors, channel1Colors)

// Later…
ledString.finish()
```

#### Ws2811

A lightweight wrapper around `ws2811_t`, and the base class for `LedStrip` and `DualPwmLedStrip`. Can be initialized with one or two channels, and any GPIO numbers (not all are valid, and validity is hardware-dependant – the underlying rpi_ws281x library will check).

There are two options for rendering with this class. The `renderWithCallback()` method takes a callback that should write color values to buffers passed in its arguments. Alternatively, one may write directly to the arrays in `ws2811.channels.0.leds` and `ws2811.channels.1.leds`, and call `render()`.

```
import rpi_ws281x_swift

let ledStrip = try! Ws2811(channel0: Channel(gpio: 18, ledCount: 10, stripType: .ws2811_GRB))

for i in 0..<10 {
  ledStrip.ws2811.channel.0.leds[i] = 0x00FF0000  // red
}

try! ledStrip.render();

```

#### Channel

The `Channel` struct holds configuration data for a single channel. It wraps a `ws2811_channel_t` struct, and provides direct access to that struct for advanced configuration via the `ws2811Channel` property.

```
var channel = Channel(gpio: LedStrip.Gpio.gpio18, ledCount: 10, stripType: .ws2811_GRB)
channel.ws2811Channel.brightness = 127  // 50% brightness
```

#### PackedColor

`PackedColor` is a type alias for `UInt32`, and provides helper methods for packing UInt8 and Float color values into WRGB UInt32s as required for rendering with this library.

```
let red = PackedColor.fromRgb(1 as Float, 0, 0)
```

#### Error handling

Most of the functions in the rpi_ws281x library return status codes to indicate success or an error. As Swift typically uses exceptions for error handling, this library wraps and throws error status as the `Ws291xError` struct. `Ws291xError` provides access to the underlying error code, and its `localizedDescription` property returns a description generated by the rpi_ws281x library.

## Using `rpi_ws281x`

The `rpi_ws281x` library is a simple bridge for the C library. For usage, please refer to the documentation for that library.

#### Mac compatibility

So that programs using this library can be built and run on Macs, the rpi_ws281x wrapper library compiles its sources only on Linux. On Mac, its headers are available but functions cannot be called as there is nothing to link to. In cross-platform code, function calls should be wrapped in `#if os(Linux)` directives:

```
import rpi_ws281x

var ws2811 = ws2811_t()

#if os(Linux)
let ret = ws2811_init(&ws2811)
#endif
```
