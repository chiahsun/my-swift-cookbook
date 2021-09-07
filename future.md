# Future

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
