import Cocoa

func printData(data: Data, count: Int) {
    for i in 0..<count {
        let offset = i * 4
        print(data[offset+0], data[offset+1], data[offset+2], data[offset+3])
    }
}

// let data = Data(bytes: rgbBytes, count: 16) // rgbBytes.withUnsafeBufferPointer(Data.init)
// let data = Data(bytes: UnsafeBufferPointer(&rgbBytes))
// var data: Data
if true {
    let sampleBytes: [Float] = [1, 2, 3, 4]
    let data = sampleBytes.withUnsafeBufferPointer(Data.init)
    printData(data: data, count: sampleBytes.count)
}

/*
if false {
    let sampleBytes: [UInt8] = [1, 2, 3, 4]
    let data = sampleBytes.withUnsafeBufferPointer(Data.init)
    printData(data: data, count: sampleBytes.count)
}*/

var rgbBytes = [Float](repeating: 0, count: 16)
for i in 0..<16 {
    rgbBytes[i] = Float(i)
}
var data = Data(count: 16)
for i in 0..<16 {
    data[i] = UInt8(rgbBytes[i])
}

print(data)
print(data[0], data[1], data[2], data[3])

print(rgbBytes[0], rgbBytes[1], rgbBytes[2], rgbBytes[3])

if false {
    var sampleBytes: [UInt8] = [1, 2, 3]
    let sampleData = Data(bytes: UnsafeRawPointer(sampleBytes), count: 3)
    print(sampleData[0])
    print(sampleData[1])
    print(sampleData[2])
}

if (false) {
var sampleBytes: [Float] = [1, 2, 3]
let sampleData = Data(bytes: UnsafeRawPointer(sampleBytes), count: 3)
print(sampleData[0])
print(sampleData[1])
print(sampleData[2])
}

// var sampleBytes: [Float] = [1, 2, 3, 4]
var sampleBytes: [Float] = [4] //, 2, 3, 4]

let ptr = UnsafeMutablePointer<Float>.allocate(capacity: sampleBytes.count)
ptr.initialize(from: sampleBytes, count: sampleBytes.count)
print(ptr)
let sampleData = Data(bytes: ptr, count: sampleBytes.count * 4)
for i in 0..<sampleBytes.count {
    let offset = i * 4
    print(sampleData[offset+0], sampleData[offset+1], sampleData[offset+2], sampleData[offset+3])
}
// print(sampleData[4], sampleData[5], sampleData[6], sampleData[7])
// print(sampleData[8], sampleData[9], sampleData[10], sampleData[11])
// print(sampleData[12], sampleData[13], sampleData[14], sampleData[15])

sampleData[15]
