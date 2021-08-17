import SwiftUI

struct EditableNameView: View {
    @Environment(\.editMode) var mode // <1>
    @State var name = ""
    
    var body: some View {
        TextField("kuma", text: $name)
            .disabled(mode?.wrappedValue == .inactive) // <2>
    }
}

struct EditorView: View {
    @Environment(\.editMode) var mode
    @State private var isOn = false
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack {
                Spacer()
                EditButton() // <3>
            }
          
            HStack {
                Text("Username: ")
                Divider().frame(height: 50)
                EditableNameView() // <4>
            }
            Toggle(isOn: $isOn) {
                 Text("Enable").bold()
            }
            .disabled(mode?.wrappedValue == .inactive)
            Spacer()
        }
        .padding()
    }
}

struct EditorView_Previews: PreviewProvider {
    static var previews: some View {
        EditorView()
    }
}
