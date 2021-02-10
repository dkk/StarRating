import SwiftUI
import StarRating

struct ContentView: View {
    var body: some View {
        Star()
            .stroke(Color.black, lineWidth: 2)            
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
