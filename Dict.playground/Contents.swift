import Cocoa


var d = [Int: Int]()
d[1] = 1
d[2] = 2

// Left side of mutating operator isn't mutable: 'v' is a 'let' constant
// for (k, v) in d {
//     v += 1
// }

// Left side of mutating operator isn't mutable: 'elem' is a 'let' constant
// for (index, elem) in d.enumerated() {
//     elem.value += 1
// }

for key in d.keys { // <1>
    d[key]! += 1
}
d // [1: 2, 2: 3]

// Left side of mutating operator isn't mutable: '$0' is immutable
// d.forEach { $0.value += 1}

d.indices.forEach { print(d[$0]) } // <2>
// Prints:
// (key: 2, value: 3)
// (key: 1, value: 2)

d.forEach { (key, value) in // <3>
    d[key]! += 1
}
d // [1: 3, 2: 4]

//  left side of mutating operator isn't mutable: 'value' is a 'let'
// d.forEach { (key, value) in
//     value += 1
// }

d.forEach { d[$0.0]! += 1 } // <3>
d // [1: 4, 2: 5]

d.keys.forEach { // <4>
    d[$0]! += 1
}
d // [1: 5, 2: 6]

//  left side of mutating operator isn't mutable: '$0' is immutable
// d.values.forEach { 
//    $0 += 1
// }
