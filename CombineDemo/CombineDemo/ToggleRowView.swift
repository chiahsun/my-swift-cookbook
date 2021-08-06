import SwiftUI

struct ToggleRowView: View {
    @Binding var toggled: Bool
    
    var terms = "Read manual 📙"
    
    var body: some View {
        HStack {
            // Ctrl + command + space
            Text(terms)
                .foregroundColor(.white)
                .font(.title)

            // https://developer.apple.com/documentation/swiftui/toggle
            Spacer()
            Toggle("Vibrate on Ring", isOn: $toggled).frame(width: 50, height: 50)
            
        }
    }
}

struct ToggleRowView_Previews: PreviewProvider {
    @State static var sampleToggled: Bool = true
    
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            ToggleRowView(toggled: $sampleToggled)
        }
    }
}
