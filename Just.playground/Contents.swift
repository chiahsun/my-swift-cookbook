import Cocoa
import Combine

Just(1).sink(receiveValue: { val in
    print("\(val)")
})
// Prints: 1

Just(1).sink(receiveCompletion: { completion in
    print("Completion: \(completion)")
}, receiveValue: { val in
    print("Received: \(val)")
})
// Prints:
// Received: 1
// Completion: finished
