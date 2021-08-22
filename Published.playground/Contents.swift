import Cocoa

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
