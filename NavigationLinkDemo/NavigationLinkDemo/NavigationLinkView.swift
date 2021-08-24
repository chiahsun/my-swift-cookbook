import SwiftUI

struct NavigationLinkView: View {
    @State var isActive = false
    
    var body: some View {
        NavigationView {
            // You can set isActive programmatically
            NavigationLink(destination: AnotherView(), isActive: $isActive) {
                Button(action: { isActive = true }) {
                    Text("Click me!")
                }
            }
        }
    }
}

struct NavigationLinkView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLinkView()
    }
}
