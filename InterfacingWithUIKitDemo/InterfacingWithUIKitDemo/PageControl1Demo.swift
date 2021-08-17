import SwiftUI

struct ClickAndShowHelper: View {
    let numberOfPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    if (currentPage > 0) {
                        currentPage -= 1
                    }
                }, label: {
                    Image(systemName: "minus.circle")
                        .resizable()
                })
                .frame(width: 60, height: 60)
                .padding()
                
                Button(action: {
                    if (currentPage < numberOfPages-1) {
                        currentPage += 1
                    }
                }, label: {
                    Image(systemName: "plus.circle")
                        .resizable()
                })
                .frame(width: 60, height: 60)
                .padding()
            }
            .padding()
            Text("\(currentPage)")
                .font(.largeTitle)
                .foregroundColor(.white)
        }
    }
}

struct PageControl1Demo: View {
    let numberOfPages = 5
    @State var currentPage: Int = 0
    
    var body: some View {
        VStack {
            ClickAndShowHelper(numberOfPages: numberOfPages, currentPage: $currentPage)
            PageControl1(numberOfPages: numberOfPages, currentpage: $currentPage)
        }
    }
}

struct PageControlDemo_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            PageControl1Demo()
        }
    }
}
