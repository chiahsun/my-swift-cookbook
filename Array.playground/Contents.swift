import Cocoa

struct MyStruct {
    var count = 0
    mutating func incre() { count += 1 }
}

var A = [MyStruct]()
A.append(MyStruct())
A.append(MyStruct())
A.append(MyStruct())

// error: cannot use mutating member on immutable value: 'a' is a 'let'
// for a in A {
//     a.incre()
// }

for (var a) in A { // <1>
    a.incre()
}
A // [0, 0, 0]

for i in A.indices { // <2>
    A[i].incre()
}
A // [1, 1, 1]

A.indices.forEach { A[$0].incre() } // <3>
A // [2, 2, 2]


// Array dict keys mutable

