import Cocoa
import Combine

// https://developer.apple.com/documentation/swift/error
// https://docs.swift.org/swift-book/LanguageGuide/ErrorHandling.html
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

