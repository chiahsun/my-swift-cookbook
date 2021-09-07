# Subscriber

## Custom Subscriber & Back Pressure

Described in

-   [Processing Published Elements with
    Subscribers](https://developer.apple.com/documentation/combine/processing-published-elements-with-subscribers)

You can define your custom subscriber and determine **back pressure**

1.  when to start receive

2.  request more data on demand

3.  do things after completion

Unlike `sink(receiveValue:)` and `assign(to:on:)` which request
unlimited demand, custom subscribers let you have fine-grained control
on the demand for both the size and timing.

[TimerPublisher.playground/Contents.swift](./TimerPublisher.playground/Contents.swift)

``` swift
let timerPub = Timer.publish(every: 1, on: .main, in: .default).autoconnect()

class MySubscriber: Subscriber {
    
    typealias Input = Date
    typealias Failure = Never
    
    func receive(subscription: Subscription) {
        print("published                  received")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { 
            subscription.request(.max(3))
        }
    }
    
    func receive(_ input: Date) -> Subscribers.Demand {
        print("\(input)  \(Date())")
        return Subscribers.Demand.none 
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Done ...")
    }
}

let mySub = MySubscriber()
print("Subscribe at \(Date())")
timerPub.subscribe(mySub) 
// Prints:
// Subscribe at 2021-09-07 04:57:55 +0000
// published                  received
// 2021-09-07 04:57:57 +0000  2021-09-07 04:57:57 +0000
// 2021-09-07 04:57:58 +0000  2021-09-07 04:57:58 +0000
// 2021-09-07 04:57:59 +0000  2021-09-07 04:57:59 +0000
```

-   We subscribe here and `receive(subscription: Subscription)` would be
    called.

-   We request a maximum of 3 resources after one seconds.

-   Data comes in `receive(_ input: Date) → Subscribers.Demand` and we
    don’t request more demand. (If you want to request more resources
    indefinitely, you can return `Subscribers.Demand.max(1))` for
    example.
