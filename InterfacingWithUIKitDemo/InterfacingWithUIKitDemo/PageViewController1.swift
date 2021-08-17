import SwiftUI

// https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
struct PageViewController1<Page: View> : UIViewControllerRepresentable {
    typealias UIViewControllerType = UIPageViewController // <1>
    
    var pages: [Page]
    
    // <2>
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        
        return pageViewController
    }

    // <2>
    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers(
            [UIHostingController(rootView: pages[0])], // <3>
            direction: .forward,
            animated: true)
    }
}


struct PageViewController1Demo: View {
    var body: some View {
        PageViewController1(pages: [Image("charleyrivers"), Image("chilkoottrail"), Image("chincoteague"), Image("hiddenlake"), Image("icybay")])
    }
}

struct PageViewController1_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController1Demo()
    }
}
