import Foundation

var signalSources: [Int32:DispatchSourceSignal] = [:]

func handleSignals(_ signals: [Int32], _ handler: @escaping () -> Void) {
  for signal in signals {
    // Ignore default handling.
    Foundation.signal(signal, SIG_IGN)

    let signalSource = DispatchSource.makeSignalSource(signal: signal, queue: .main)
    signalSource.setEventHandler(handler: handler)
    signalSource.resume()
    signalSources[signal] = signalSource
  }
}
