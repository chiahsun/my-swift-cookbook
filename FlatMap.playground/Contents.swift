import Cocoa
import Combine

let numbers = [[1, 2], [3, 4, 5], [6], [7, 8, 9, 10]]
print(numbers.flatMap { $0 })
// Prints: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

let x = PassthroughSubject<[String], Never>()
let cancellable = x.sink { value in
    print("Value(sink only): \(value)")
}

x.send(["A", "B", "C", "D"])
x.send(["E", "F"])
// Prints:
// Value(sink only): ["A", "B", "C", "D"]
// Value(sink only): ["E", "F"]

cancellable.cancel() // Add this just to avoid trigger the above subscriber again

x.flatMap { value in
    value.publisher
}
.sink(receiveCompletion: { completion in
    print("Completion(flatMap): \(completion)")
}, receiveValue: { value in
    print("Value(flatMap): \(value)")
})
x.send(["A", "B", "C", "D"])
x.send(["E", "F"])
x.send(completion: Subscribers.Completion.finished)
// Prints:
// Value(flatMap): A
// Value(flatMap): B
// Value(flatMap): C
// Value(flatMap): D
// Value(flatMap): E
// Value(flatMap): F
// Completion(flatMap): finished

