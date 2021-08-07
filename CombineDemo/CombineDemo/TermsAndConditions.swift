import SwiftUI
import Combine

class TermsAndConditionsModel : ObservableObject {  // <1>
    @Published var readManualDone = false    // <2>
    @Published var practiced = false         // <2>
    @Published var teacherApproved = false   // <2>
   
    @Published var granted = false           // <3>
        
    private var cancellable: AnyCancellable? // <4>
    
    init() {
        cancellable = Publishers.CombineLatest3($readManualDone, $practiced, $teacherApproved).map { // <5> <6> <7>
            return $0 && $1 && $2
        }
        .assign(to: \.granted, on: self) // <8>
    }
}


struct TermsAndConditions: View {
    @ObservedObject var model: TermsAndConditionsModel

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            VStack {
                Header(headerName: "Terms & Conditions")
                
                ToggleRowView(toggled: $model.readManualDone)
                ToggleRowView(toggled: $model.practiced, terms: "Practiced in simulator 🕹")
                ToggleRowView(toggled: $model.teacherApproved, terms: "Teacher approved 🧙‍♂️")
           
                CustomButton(buttonText: "Play", isEnabled: $model.granted) // <9>
                
                Spacer()
            }
            .padding(15)
        }
    }
}

struct TermsAndConditions_Previews: PreviewProvider {
    @StateObject static var model = TermsAndConditionsModel() // <10>
    static var previews: some View {
        TermsAndConditions(model: model)
    }
}
