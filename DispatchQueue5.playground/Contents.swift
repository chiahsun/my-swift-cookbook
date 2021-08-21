import Cocoa

print("Start ...")
// Main dispatch queue is serial global dispatch queue
DispatchQueue.main.async {
    print("Task 1")
}
DispatchQueue.main.async {
    print("Task 2")
}
DispatchQueue.main.async {
    print("Task 3")
}

print("End ...")
