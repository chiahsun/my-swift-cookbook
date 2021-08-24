import Cocoa

class SomeClass {
    @Published var val = 0
}

let c = SomeClass()

// https://developer.apple.com/documentation/combine/fail/sink(receivevalue:)
c.$val.sink { receiveValue in
    print("val is \(receiveValue)")
}


c.val = 1
c.val = 2
