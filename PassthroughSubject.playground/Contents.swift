import Cocoa
import Combine

let x = PassthroughSubject<Int, Never>()

let cancellable = x.sink { receivedValue in
    print("Receive(cancellable): \(receivedValue)")
}
x.send(1)
x.send(2)
cancellable.cancel()
x.send(3)
// Receive(cancellable): 1
// Receive(cancellable): 2

x.sink { receivedValue in
    print("Receive: \(receivedValue)")
}

x.send(1)
x.send(2)
x.send(completion: Subscribers.Completion.finished)
x.send(3)
// Prints:
// Receive: 1
// Receive: 2
