import SwiftUI

struct NavigationLinkView: View {

    @State var isActive = false
    @State var isActive2 = false

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // <1>
                NavigationLink(destination: AnotherView()) {
                    Text("Click me!")
                }

                // <2>
                NavigationLink(destination: AnotherView(), isActive: $isActive) {
                    Button(action: { isActive = true }) {
                        Text("Click me!")
                    }
                }

                // <3>
                NavigationLink(destination: AnotherView(), isActive: $isActive2) { EmptyView() }
                Button(action: { isActive2 = true }) {
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
