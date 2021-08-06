import SwiftUI

class Library: ObservableObject {
    @Published var books = [Book]()
    
    init() {
        books.append(Book(title: "Harry Potter"))
        books.append(Book(title: "The Lord of the Rings"))
    }
}

struct LibraryView2: View {
    @EnvironmentObject var library: Library // <1>
    
    var body: some View {
        List(library.books) { book in
            BookView(book: book)
        }
    }
}

struct LibraryView2_Previews: PreviewProvider {
    static var previews: some View {
        LibraryView2()
            .environmentObject(Library()) // <2>
    }
}
