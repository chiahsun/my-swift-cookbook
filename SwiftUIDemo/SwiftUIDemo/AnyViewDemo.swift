import SwiftUI

struct AnyViewDemo: View {
    @State var flag: Bool = true
    
    var sampleView: AnyView {
        if flag {
            return AnyView(
                Image(systemName: "circle")
                    .resizable()
                    .foregroundColor(Color.red)
                    .frame(width: 200, height: 200))
        } else {
            return AnyView(Text("Hello World"))
        }
    }
    
    var body: some View {
        ZStack {
            sampleView
            VStack {
                Spacer()
                Button(action: { flag = !flag}) {
                    Text("Click me!")
                }
                .padding(100)
            }
        }
    }
}

struct AnyView_Previews: PreviewProvider {
    static var previews: some View {
        AnyViewDemo()
    }
}
