import SwiftUI

struct GeometryReaderDemo: View {
    var body: some View {
        GeometryReader { metrics in
            Button(action: {  }) {
                Text("Back").font(.largeTitle)
            }
            .frame(width: metrics.size.width, height: metrics.size.height, alignment: .topLeading)
            .padding(25)
        }
    }
}

struct GeometryReaderDemo_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderDemo()
    }
}
