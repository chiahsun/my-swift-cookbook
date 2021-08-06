import SwiftUI

// Identifiable is used for LibraryView2 ForEach
class Book: ObservableObject, Identifiable {    // <1>
    @Published var title = "Harry Potter" // <2>
    let identifier = UUID()
    
    init() {
    }
    init(title: String) {
        self.title = title
    }
}

struct BookView: View {
    @ObservedObject var book: Book   // <3>
    
    var body: some View {
        Text(book.title)
    }
}


struct BookEditView: View {
    @ObservedObject var book: Book   // <3>

    var body: some View {
        TextField("Edit", text: $book.title)
            .multilineTextAlignment(.center)
            
    }
}
// https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app
struct LibraryView: View {
    @StateObject var book = Book()  // <4>
    
    var body: some View {
        VStack(alignment: .center) {
            BookView(book: book)
            BookEditView(book: book)
        }
    }
}

struct LibraryView_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView()
    }
}
