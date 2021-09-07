# Array

## Modify array elements in iteration

Described in

-   [Change value of array in
    for-loop](https://developer.apple.com/forums/thread/652006)

-   [Iterate through Swift array and change
    values](https://stackoverflow.com/questions/54973104/iterate-through-swift-array-and-change-values)

[Array.playground/Contents.swift](./Array.playground/Contents.swift)

``` swift
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

for (var a) in A { 
    a.incre()
}
A // [0, 0, 0]

for i in A.indices { 
    A[i].incre()
}
A // [1, 1, 1]

A.indices.forEach { A[$0].incre() } 
A // [2, 2, 2]
```

-   `var a` only makes the copied value mutable

-   1\. Use indices

-   2\. Use forEach
