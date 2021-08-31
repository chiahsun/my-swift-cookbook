import SwiftUI

struct ImageView: View {
    var body: some View {
        Image("IMG_1768")
            .byProportion(proportion: 0.2, x: 4, y: 4)
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
    }
}
