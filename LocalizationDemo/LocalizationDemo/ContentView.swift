import SwiftUI

struct ContentView: View {
    
    var name: LocalizedStringKey = "hello2"
    var body: some View {
        // It shows hello too on device and
        // fail for preview only ...
        Text(name)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.locale, .init(identifier: "zh-Hant"))
    }
}
