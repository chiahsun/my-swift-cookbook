import Cocoa
import Combine

let x = CurrentValueSubject<Int, Never>(0)

let cancellable = x.sink { receivedValue in
    print("Receive(cancellable): \(receivedValue)")
}
x.send(1)
x.send(2)
cancellable.cancel()
x.send(3)
// Prints:
// Receive(cancellable): 0
// Receive(cancellable): 1
// Receive(cancellable): 2

print(x.value) // Prints: 3
