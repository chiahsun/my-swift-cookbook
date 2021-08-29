import SwiftUI

@main
struct LocalizationDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Change this for running your app on device/simulator
                .environment(\.locale, .init(identifier: "zh-Hant"))
        }
    }
}
