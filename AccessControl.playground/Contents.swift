import Cocoa

class SomeClass {
    private(set) var val = 10
    
    func reset() {
        val = 0
    }
}


let c = SomeClass()

// c.val = 2 // Cannot assign to property: 'val' setter is inaccessible
print(c.val) // Prints: 10
c.reset()
print(c.val) // Prints: 0
