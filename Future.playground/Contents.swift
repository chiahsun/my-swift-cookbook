import Cocoa
import Combine

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

let cancellable2 = Future<Int, Never>() { promise in
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        promise(Result.success(2))
    }
}.sink(receiveValue: { val in
    print("Future: \(val)")
})
// Prints:
// Future: 2
