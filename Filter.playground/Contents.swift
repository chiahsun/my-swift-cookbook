import Cocoa
import Combine

// https://developer.apple.com/documentation/combine/publishers-flatmap-publisher-operators
[1, 2, 3, 4, 5].publisher
    .filter {
        $0 % 2 == 0
    }
    .sink {
        print ("Even number: \($0)")
    }
