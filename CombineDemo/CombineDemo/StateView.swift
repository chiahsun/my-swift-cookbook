import SwiftUI

struct StateView: View {
    @State var count = 0
    var body: some View {
        VStack {
            Text("\(count)")
            Button(action: { count += 1 }) { Text("Click me")
            }
        }
    }
}

// https://stackoverflow.com/questions/56718802/how-to-update-a-swiftui-view-state-from-outside-uiviewcontroller-for-example
// Conclusion: You cannot change state from outside.
struct AllView: View {
    var view = StateView()
    var stateView: some View {
        // let view =
        return view
    }
    var body: some View {
        VStack {
            stateView
            Button(action: {
                view.count += 1
            }) {
                Text("Click me plz")
            }
        }
    }
}

struct StateView_Previews: PreviewProvider {
    static var previews: some View {
        // StateView()
        AllView()
    }
}
