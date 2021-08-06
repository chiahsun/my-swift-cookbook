import SwiftUI

struct TermsAndConditions: View {
    @State private var readManualDone = false
    @State private var practiced = false
    @State private var teacherApproved = false


    var body: some View {
        ZStack {
     
            Color.black.ignoresSafeArea()
            VStack {
                Header(headerName: "Terms & Conditions")
                
                ToggleRowView(toggled: $readManualDone)
                ToggleRowView(toggled: $practiced, terms: "Practiced in simulator 🕹")
                ToggleRowView(toggled: $teacherApproved, terms: "Teacher approved 🧙‍♂️")
           
                
                CustomButton(buttonText: "Play")
                
                Spacer()
            }
            .padding(15)
        }
    }
}

struct TermsAndConditions_Previews: PreviewProvider {
    static var previews: some View {
        TermsAndConditions()
    }
}
