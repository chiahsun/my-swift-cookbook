import SwiftUI

struct CustomButton: View {
    let disabled = Color(red: 85/255, green: 85/255, blue: 85/255)
    
    var buttonText = "Create Account"
    @Binding var isEnabled: Bool
    
    var body: some View {
        Button(action: {}, label: {
            Text(buttonText)
        }).foregroundColor(.white).frame(maxWidth: .infinity)
        .padding(18)
        .background(isEnabled ? .blue : disabled)
        .cornerRadius(15)
        .overlay(RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 2))
       
        .font(Font.headline.weight(.bold))
        .padding(.top, 40)
        .disabled(!isEnabled)
    }
}

struct CustomButton_Previews: PreviewProvider {
    @State static var sampleEnabled = true
    
    static var previews: some View {
        CustomButton(isEnabled: $sampleEnabled)
    }
}
