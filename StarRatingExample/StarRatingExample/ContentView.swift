import SwiftUI
import StarRating


struct ContentView: View {
    var body: some View {
        Text(StarRatingText.text)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
