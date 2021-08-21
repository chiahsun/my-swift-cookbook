import Cocoa

let serialQueue = DispatchQueue(label: "concurrent", attributes: .concurrent)
print("Start ...")
serialQueue.async {
    print("Going to sleep 2 second")
    sleep(2)
    print("Task 1")
}
serialQueue.async {
    print("Going to sleep 1 second")
    sleep(1)
    print("Task 2")
}

print("End ...")
