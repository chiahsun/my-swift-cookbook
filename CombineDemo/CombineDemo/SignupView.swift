import SwiftUI

struct Header: View {
    var headerName = "Wizard School Signup"
    var body: some View {
        Text(headerName).foregroundColor(.white)
            .font(.title)
            .padding(.bottom, 40)
    }
}

// https://stackoverflow.com/questions/59150320/how-to-bold-text-in-textfield-swiftui
struct SignupView: View {
    
    @State var wizardName: String = ""
    @State var password: String = ""
    @State var passwordRepeat: String = ""
    @State var isEnabled = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
      
                Header()
            
                InputRowView(textInput: $wizardName)
                InputRowView(icon: "lock.circle", placeholderText: "Password", textInput: $password)
                InputRowView(icon: "lock.circle", placeholderText: "Repeat password", textInput: $passwordRepeat)
                
                // https://stackoverflow.com/questions/58928774/button-border-with-corner-radius-in-swift-ui
             
                CustomButton(isEnabled: $isEnabled)
                
                Spacer()
            }.padding(15)
        }
    }
}

struct SignupView_Previews: PreviewProvider {
    static var previews: some View {
        SignupView()
    }
}
