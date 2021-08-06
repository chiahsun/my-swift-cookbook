import SwiftUI


// https://stackoverflow.com/questions/57688242/swiftui-how-to-change-the-placeholder-color-of-the-textfield
extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {

        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

struct InputRowView: View {
    var icon = "person.crop.circle"
    var placeholderText = "Wizard name"
    @Binding var textInput: String
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .resizable()
                .foregroundColor(.white)
                .frame(width: 40, height: 40).padding(10)
            TextField("Wizard name", text: $textInput)
                .foregroundColor(.white)
                .font(.largeTitle)
                .disableAutocorrection(true)
                .placeholder(when: textInput.isEmpty, placeholder: {Text(placeholderText).foregroundColor(.gray)
                    .font(.title2)
                })
        }
    }
}

struct InputRowView_Previews: PreviewProvider {
    @State static var sampleInput: String = ""
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            InputRowView(textInput: $sampleInput)
            // InputRowView(icon: "lock.circle", placeholderText: "password", textInput: $sampleInput)
        }
    }
}
