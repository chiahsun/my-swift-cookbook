import Cocoa

let serialQueue = DispatchQueue(label: "serial")
print("Start ...")
serialQueue.sync {
    print("Going to sleep 1 second")
    sleep(1)
    print("Task 1")
}
serialQueue.async {
    print("Task 2")
}

print("End ...")
