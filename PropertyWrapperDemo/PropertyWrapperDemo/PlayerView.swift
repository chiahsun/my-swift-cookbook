import SwiftUI

struct PlayButton: View {
    @Binding var isPlaying: Bool // <2>
    var action: () -> Void
    var body: some View {
        Button(action: self.action) {
            Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill")
            .resizable()
            .frame(width: 75, height: 75, alignment: .center)
            .foregroundColor(.black)
        }
    }
}

// https://developer.apple.com/documentation/swiftui/state

struct PlayerView: View {
    @State var isPlaying: Bool // <1>
    
    var body: some View {
        VStack(spacing: 20) {
            Button(action: {
                isPlaying = !isPlaying // <2>
            }) {
                Image(systemName: isPlaying ? "play.circle.fill" : "pause.circle.fill"
                )
                    .resizable()
                    .frame(width: 75, height: 75, alignment: .center)
                    .foregroundColor(.black)
            }
            
            PlayButton(isPlaying: $isPlaying, action: { // <3>
                isPlaying = !isPlaying
            })
        }
     
    }
}

struct PlayerView_Previews: PreviewProvider {
    static var previews: some View {
        PlayerView(isPlaying: false)
    }
}
