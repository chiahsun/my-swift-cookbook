import SwiftUI

@main
struct PropertyWrapperDemoApp: App {
    @StateObject var library = Library() // <1>
    
    var body: some Scene {
        WindowGroup {
            LibraryView2()
                .environmentObject(library) // <2>
        }
    }
}
