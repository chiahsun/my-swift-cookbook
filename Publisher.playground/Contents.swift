import Cocoa

[1, 2, 3, 4].publisher.sink(receiveValue: { val in
    print("Received: \(val)")
})
// Received: 1
// Received: 2
// Received: 3
// Received: 4
