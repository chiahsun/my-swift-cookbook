import Cocoa

// https://docs.swift.org/swift-book/LanguageGuide/Properties.html

@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOrLess var width: Int
}

var rectangle = SmallRectangle()

rectangle.height = 10
rectangle.width = 24

print(rectangle.height, rectangle.width)


// https://docs.swift.org/swift-book/LanguageGuide/Properties.html
// https://docs.swift.org/swift-book/ReferenceManual/Attributes.html
@propertyWrapper
struct SmallNumber {
    private var number: Int
    private var maximum: Int
    
    var wrappedValue: Int {
        get { number }
        set { number = min(newValue, maximum) }
    }
    
    private static let default_maximum = 10
    
    init() { // <1>
        number = 0
        maximum = SmallNumber.default_maximum
    }
    
    init(wrappedValue: Int) { // <2>
        maximum = SmallNumber.default_maximum
        number = min(wrappedValue, maximum)
    }
    
    init(wrappedValue: Int, maximum: Int) { // <3>
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}

struct SomeStruct {
    // Use init()
    @SmallNumber var a: Int
    
    // Use init(wrappedValue:)
    @SmallNumber var b = 20
    
    // Use init(wrappedValue:maximum:)
    @SmallNumber(maximum: 100) var c = 30
    @SmallNumber(wrappedValue: 40, maximum: 200) var d
}

var s = SomeStruct()
print(s.a, s.b, s.c, s.d) // Prints: 0 10 30 40
s.a = 500
s.b = 500
s.c = 500
s.d = 500
print(s.a, s.b, s.c, s.d) // Prints: 10 10 100 200

enum Size {
    case small, medium, large
}

@propertyWrapper
struct Vector {
    private var x = 0.0
    private var y = 0.0
    
    var wrappedValue: Double {
        get { sqrt(pow(x, 2) + pow(y, 2)) }
    }
    
    var projectedValue: Size { // <1>
        get {
            switch wrappedValue {
            case _ where wrappedValue <= 5:
                return Size.small
            case _ where wrappedValue <= 13:
                return Size.medium
            default:
                return Size.large
            }
        }
    }
    
    init(x: Double, y: Double) {
        self.x = x
        self.y = y
    }
}

struct AnotherStructure {
    @Vector(x: 3, y: 4) var smallVector
    @Vector(x: 5, y: 12) var mediumVector
    @Vector(x: 7, y: 24) var largeVector
}

var anotherStructure = AnotherStructure()
anotherStructure.smallVector   // 5
anotherStructure.$smallVector  // small
anotherStructure.mediumVector  // 13
anotherStructure.$mediumVector // medium
anotherStructure.largeVector   // 25
anotherStructure.$largeVector  // large
