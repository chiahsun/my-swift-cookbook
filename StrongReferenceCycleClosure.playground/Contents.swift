import Cocoa

class SomeClass {
    var name: String
    
    init(name: String) {
        print("init")
        self.name = name
    }
    
    lazy var someProperty: () -> String = {
        return "\(self.name) is awesome"
    }
    
    deinit {
        print("deinit")
    }
}

func f() {
    let c = SomeClass(name: "c")
    let p = c.someProperty
}

f()
// sleep(1)
