import SwiftUI

// https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
struct PageViewController2<Page: View> : UIViewControllerRepresentable {
    typealias UIViewControllerType = UIPageViewController
    
    var pages: [Page]
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator // <4>
        
        return pageViewController
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers(
            [context.coordinator.controllers[0]], // <2>
            direction: .forward,
            animated: true)
    }
    
    // <1>
    class Coordinator: NSObject, UIPageViewControllerDataSource { // <3>
        typealias ParentType = PageViewController2
        
        var parent: ParentType
        var controllers = [UIViewController]()
        
        init(_ pageViewController: ParentType) {
            parent = pageViewController
            
            controllers = parent.pages.map { UIHostingController(rootView: $0) } // <2>
        }
        
        // <3>
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index-1]
        }
        
        // <3>
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index+1]
        }
    }
    
    // <1>
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct PageViewController2Demo: View {
    var body: some View {
        PageViewController2(pages: [Image("charleyrivers"), Image("chilkoottrail"), Image("chincoteague"), Image("hiddenlake"), Image("icybay")])
    }
}

struct PageViewController2_Previews: PreviewProvider {
    static var previews: some View {
        PageViewController2Demo()
    }
}
