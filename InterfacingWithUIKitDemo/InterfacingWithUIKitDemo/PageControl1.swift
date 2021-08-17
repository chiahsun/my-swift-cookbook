import SwiftUI

// https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
// Section 4

struct PageControl1: UIViewRepresentable {
    var numberOfPages: Int
    @Binding var currentpage: Int // <1>
    
    func makeUIView(context: Context) -> UIPageControl {
        let control = UIPageControl()
        control.numberOfPages = numberOfPages
        
        return control
    }
    
    // <2>
    func updateUIView(_ uiView: UIPageControl, context: Context) {
        uiView.currentPage = currentpage
    }
}

struct PageControl_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            PageControl1(numberOfPages: 5, currentpage: .constant(2))
        }
    }
}
