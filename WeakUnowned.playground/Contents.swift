import Cocoa

class SomeClass {
    typealias MyCoolFuncType = () -> Void
    
    var f: MyCoolFuncType?
    var g: MyCoolFuncType?
    
    var name: String
    
    init(name: String) {
        print("init(\(name))")
        self.name = name
    }
    deinit { print("deinit(\(name))") }
}

func pf() {
    let c = SomeClass(name: "without weak")
    c.f = { () -> Void in   // <1>
        print("\(c.name)")  // <2>
    }
}

pf()
// Prints:
// init(without weak) // <3>

func pf2() -> SomeClass.MyCoolFuncType {
    let c = SomeClass(name: "with weak")

    c.f = { [weak c] () -> Void in // <1>
        print("\(c?.name)")
    }
    let g = { [unowned c] () -> Void in // <2>
        print("\(c.name)")
    }
    c.g = g
    return g
}
let g = pf2()
// Prints:
// init(with weak)
// deinit(with weak)

// You should not try to call a function with unowned reference after the object is released
// g() // error: Execution was interrupted, reason: signal SIGABRT.


