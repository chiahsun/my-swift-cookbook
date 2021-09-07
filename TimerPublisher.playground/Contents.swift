import Cocoa

import Combine

// https://developer.apple.com/documentation/combine/processing-published-elements-with-subscribers
let timerPub = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

class MySubscriber: Subscriber {
    
    typealias Input = Date
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        print("published                  received")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { // <2>
            subscription.request(.max(3))
        }
    }
    
    func receive(_ input: Date) -> Subscribers.Demand {
        print("\(input)  \(Date())")
        return Subscribers.Demand.none // <3>
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Done ...")
    }
}

let mySub = MySubscriber()
print("Subscribe at \(Date())")
timerPub.subscribe(mySub) // <1>
// Prints:
// Subscribe at 2021-09-07 04:57:55 +0000
// published                  received
// 2021-09-07 04:57:57 +0000  2021-09-07 04:57:57 +0000
// 2021-09-07 04:57:58 +0000  2021-09-07 04:57:58 +0000
// 2021-09-07 04:57:59 +0000  2021-09-07 04:57:59 +0000

