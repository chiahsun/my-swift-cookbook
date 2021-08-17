import SwiftUI

// https://developer.apple.com/tutorials/swiftui/interfacing-with-uikit
struct PageViewController<Page: View> : UIViewControllerRepresentable {
    typealias UIViewControllerType = UIPageViewController
    
    @Binding var currentPage: Int // <1>
    var pages: [Page]
    
    func makeUIViewController(context: Context) -> UIPageViewController {
        let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
        pageViewController.dataSource = context.coordinator
        pageViewController.delegate = context.coordinator // <4>
        
        return pageViewController
    }

    func updateUIViewController(_ uiViewController: UIPageViewController, context: Context) {
        uiViewController.setViewControllers(
            [context.coordinator.controllers[currentPage]], // <2>
            direction: .forward,
            animated: true)
    }
    
    class Coordinator: NSObject, UIPageViewControllerDataSource
                       , UIPageViewControllerDelegate // <3>
    {
        typealias ParentType = PageViewController
        
        var parent: ParentType
        var controllers = [UIViewController]()
        
        init(_ pageViewController: ParentType) {
            parent = pageViewController
            
            controllers = parent.pages.map { UIHostingController(rootView: $0) }
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index == 0 {
                return controllers.last
            }
            return controllers[index-1]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            guard let index = controllers.firstIndex(of: viewController) else {
                return nil
            }
            if index + 1 == controllers.count {
                return controllers.first
            }
            return controllers[index+1]
        }
        
        // ...
        
        // <3>
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
            if completed,
               let visibleViewController = pageViewController.viewControllers?.first,
               let index = controllers.firstIndex(of: visibleViewController) {
                parent.currentPage = index
            }
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}


struct PageViewControllerDemo: View {
    @State private var currentPage = 0 // <1>
    
    var body: some View {
        VStack {
            PageViewController(
                currentPage: $currentPage, // <1>
                pages: [Image("charleyrivers"), Image("chilkoottrail"), Image("chincoteague"), Image("hiddenlake"), Image("icybay")]
            )
            Text("Current Page: \(currentPage)")
        }
    }
}

// Images: https://developer.apple.com/tutorials/swiftui/building-lists-and-navigation
struct PageViewController_Previews: PreviewProvider {
    static var previews: some View {
        PageViewControllerDemo()
    }
}
