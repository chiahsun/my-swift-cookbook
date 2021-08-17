import SwiftUI

struct PageView: View {
    @State private var currentPage = 0
    
    var images = [Image("charleyrivers"), Image("chilkoottrail"), Image("chincoteague"), Image("hiddenlake"), Image("icybay")].map { $0.resizable() }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            PageViewController(
                currentPage: $currentPage,
                pages: images
            )
            
            PageControl(numberOfPages: images.count, currentpage: $currentPage)
                .frame(width: CGFloat(images.count * 18))
        }
    }
}

struct ContentView: View {
    var body: some View {
        PageView()
           .aspectRatio(3/2, contentMode: .fit)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ContentView()
        }
    }
}
