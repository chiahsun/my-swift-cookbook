import SwiftUI
import OrderedDictionary // <1>

struct ContentView: View {
    let dict: OrderedDictionary = [ // <2>
        "a": 1,
        "b": 2
    ]
    var body: some View {
        Text("Hello, world!")
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
