import Foundation

var signalSources: [Int32:() -> Void] = [:]

func handleSignal(_ signal: Int32, _ handler: @escaping () -> Void) {
  // Ignore default handling.
  Foundation.signal(signal, SIG_IGN)

  let signalSource = DispatchSource.makeSignalSource(signal: signal, queue: .main)
  signalSource.setEventHandler(handler: handler)
  signalSources[signal] = handler
}
