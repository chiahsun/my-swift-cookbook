import SwiftUI

// https://stackoverflow.com/questions/58613503/how-to-make-list-with-single-selection-with-swiftui

struct SelectionMenu: View {
    let items: [String]
    @State var selected: String? = nil
    
    var body: some View {
        List {
            ForEach(items, id: \.self) { item in
                SelectionCell(item: item, selected: self.$selected)
            }
        }
    }
}

struct SelectionCell: View {
    let item: String
    @Binding var selected: String?
    
    var body: some View {
        Text(item)
            .foregroundColor((item == selected) ? Color.red : Color.black)
            .font(.largeTitle)
            .onTapGesture {
                selected = item
            }
    }
}

struct SelectionMenu_Previews: PreviewProvider {
    static var previews: some View {
        SelectionMenu(items: ["A", "B", "C", "D"])
    }
}
