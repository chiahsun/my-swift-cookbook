import Cocoa

let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

// 1
func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}

print(names.sorted(by: backward))

// 2
names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
// 3
names.sorted(by: { s1, s2 in return s1 > s2 })
// 4
names.sorted(by: { s1, s2 in s1 > s2})
// 5
names.sorted(by: { $0 > $1 })
// 6
names.sorted(by: >)

//Trailing closures
// 7
names.sorted() { $0 > $1 }
// 8
names.sorted { $0 > $1 }

// All of the above equal to: ["Ewa", "Daniella", "Chris", "Barry", "Alex"]

