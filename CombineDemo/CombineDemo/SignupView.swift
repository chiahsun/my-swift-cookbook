import SwiftUI

// https://stackoverflow.com/questions/59150320/how-to-bold-text-in-textfield-swiftui
struct SignupView: View {
    let buttonColor = Color(red: 85/255, green: 85/255, blue: 85/255)
    
    @State var wizardName: String = ""
    @State var password: String = ""
    @State var passwordRepeat: String = ""

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            VStack {
                Text("Wizard School Signup").foregroundColor(.white)
                    .font(.title)
                    .padding(.bottom, 40)
                
            
                InputRowView(textInput: $wizardName)
                InputRowView(icon: "lock.circle", placeholderText: "Password", textInput: $password)
                InputRowView(icon: "lock.circle", placeholderText: "Repeat password", textInput: $passwordRepeat)
                
                // https://stackoverflow.com/questions/58928774/button-border-with-corner-radius-in-swift-ui
                Button(action: {}, label: {
                    Text("Create Account")
                }).foregroundColor(.white).frame(maxWidth: .infinity)
                .padding(18)
                .background(buttonColor)
                .cornerRadius(15)
                .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
               
                .font(Font.headline.weight(.bold))
                .padding(.top, 40)
               
                
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
