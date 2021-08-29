import SwiftUI

struct ContentView: View {
    @Environment(\.locale) var locale
    
    var name: String {
        return LocalizedStringKey("hello").stringValue(locale: locale)
    }
    
    var none: String? {
        return LocalizedStringKey("none").stringOptionalValue(locale: locale)
    }
    
    var name2: LocalizedStringKey = "hello"
    var body: some View {
        VStack {
            Text(name).padding()
            Text(none ?? "is nil").padding()
            Text(locale.languageCode ?? "nil")
            Text(locale.identifier)
            Text(Locale.current.languageCode ?? "nil")
            Text(Locale.autoupdatingCurrent.languageCode ?? "nil")
            
            Text(name2).padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            // Change this for your preview
            // .environment(\.locale, .init(identifier: "en"))
            .environment(\.locale, .init(identifier: "zh-Hant"))
            // .environment(\.locale, .init(identifier: "ja"))
    }
}
