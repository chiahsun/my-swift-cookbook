import Cocoa

// https://developer.apple.com/documentation/swift/range
for i in 1...3 {
    // Prints: 1 2 3
    print(i, terminator: " ")
}
print()
for i in 1..<3 {
    // Prints: 1 2
    print(i, terminator: " ")
}
print()
for i in stride(from: 3, to: 1, by: -1) {
    // Prints: 3 2
    print(i, terminator: " ")
}
