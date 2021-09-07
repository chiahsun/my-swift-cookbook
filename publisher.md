# Publisher

Described in

-   [Publisher](https://developer.apple.com/documentation/combine/publisher)

An example of publisher.

[Publisher.playground/Contents.swift](./Publisher.playground/Contents.swift)

``` swift
[1, 2, 3, 4].publisher.sink(receiveValue: { val in
    print("Received: \(val)")
})
// Received: 1
// Received: 2
// Received: 3
// Received: 4
```

## Just

Described in

-   [Just](https://developer.apple.com/documentation/combine/just)

<!-- -->

    A publisher that emits an output to each subscriber just once, and then finishes.

[Just.playground/Contents.swift](./Just.playground/Contents.swift)

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

## PassthroughSubject

Described in

-   [PassthroughSubject](https://developer.apple.com/documentation/combine/passthroughsubject)

<!-- -->

    A subject that broadcasts elements to downstream subscribers.
    Unlike CurrentValueSubject, a PassthroughSubject doesn’t have an initial value or a buffer of the most recently-published element.

[PassthroughSubject.playground/Contents.swift](./PassthroughSubject.playground/Contents.swift)

``` swift
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
```

## CurrentValueSubject

Described in

-   [CurrentValueSubject](https://developer.apple.com/documentation/combine/currentvaluesubject)

<!-- -->

    Unlike PassthroughSubject, CurrentValueSubject maintains a buffer of the most recently published element.

CurrentValueSubject has a state(initial value or updated value).

[CurrentValueSubject.playground/Contents.swift](./CurrentValueSubject.playground/Contents.swift)

``` swift
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
```

## Future

Described in

-   [Using Combine for Your App’s Asynchronous
    Code](https://developer.apple.com/documentation/combine/using-combine-for-your-app-s-asynchronous-code)

[Future.playground/Contents.swift](./Future.playground/Contents.swift)

``` swift
func performAsync() -> Future<Int, Never> {
    return Future() { promise in
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            promise(Result.success(1))
        }
    }
}

let cancellable = performAsync()
.sink(receiveValue: { val in
    print("Future: \(val)")
})
// Prints:
// Future: 1
```

Then, we give a future with error example.

[FutureWithError.playground/Contents.swift](./FutureWithError.playground/Contents.swift)

``` swift
enum SampleError: Error {
    case tooCool, tooAwesome
}

Future<Int, Error> { promise in
    promise(.success(1))
}.sink(receiveCompletion: { completion in
    print("Completion: \(completion)")
    completion as! Subscribers.Completion<Error>
}, receiveValue: { val in
    print("Received: \(val)")
})
// Prints:
// Received: 1
// Completion: finished
```

``` swift
Future<Int, Error> { promise in
    promise(.failure(SampleError.tooCool))
}.sink(receiveCompletion: { completion in
    print("Completion: \(completion)")
    completion as! Subscribers.Completion<Error>
    
    switch completion {
    case .finished: break
    case .failure(let anError):
        // https://stackoverflow.com/questions/51306804/swift-is-there-a-way-to-match-an-error-without-throwing
        switch anError {
        case SampleError.tooCool:
            print("Handle tooCool error")
        case SampleError.tooAwesome:
            print("Handle tooAwesome error")
        default:
            print("Handle unknown error")
        }
    }
}, receiveValue: { val in
    print("Received: \(val)")
})
// Prints:
// Completion: failure(__lldb_expr_171.SampleError.tooCool)
// Handle tooCool error
```

## @Published

[Published.playground/Contents.swift](./Published.playground/Contents.swift)

``` swift
class SomeModel: ObservableObject {
    @Published var someVar = 0
}

let m = SomeModel()
m.$someVar.sink(receiveValue: { val in
    print("\(val)")
})

m.someVar = 2
// Prints:
// 0
// 2
```

`@Published` in SwiftUI is one kind of Publisher.
