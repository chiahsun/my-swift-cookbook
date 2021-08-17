import SwiftUI
import UIKit
// https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
// Section 4

struct PageControl: UIViewRepresentable {
    typealias UIViewType = UIPageControl // <1>
    
    var numberOfPages: Int
    @Binding var currentpage: Int
    
    func makeUIView(context: Context) -> UIViewType {
        let control = UIViewType()
        control.numberOfPages = numberOfPages
        control.addTarget(context.coordinator, action: #selector(Coordinator.updateCurrentPage(sender:)), for: .valueChanged) // <5>
        
        return control
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.currentPage = currentpage
    }
    
    // <2>
    class Coordinator: NSObject {
        typealias ParentType = PageControl

        var control: ParentType
        
        init(_ control: ParentType) {
            self.control = control
        }
        
        // <3>
        @objc
        func updateCurrentPage(sender: UIViewType) {
            control.currentpage = sender.currentPage
        }
    }
    
    // <4>
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct PageControlDemo: View {
    let numberOfPages = 5
    @State var currentPage: Int = 0
    
    var body: some View {
        VStack {
            ClickAndShowHelper(numberOfPages: numberOfPages, currentPage: $currentPage)
            
            PageControl(numberOfPages: numberOfPages, currentpage: $currentPage)
        }
    }
}

struct PageControl2_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            PageControlDemo()
        }
    }
}
