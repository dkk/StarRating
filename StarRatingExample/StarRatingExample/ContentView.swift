import SwiftUI
import StarRating

struct ContentView: View {
    var bigStar: some View {
        ZStack {
            Star(vertices: 5, weight: 0.45)
                .fill(LinearGradient(
                    gradient: .init(colors: [.pink, .blue]),
                    startPoint: .init(x: 0, y: 0),
                    endPoint: .init(x: 1, y: 1)
                ))
                .frame(width: 300, height: 300, alignment: .center)
                .overlay(Star().stroke(Color.white, lineWidth: 4))
                .shadow(
                    color: Color.Example.shadow,
                    radius: 7
                )
            
            Text("StarRating")
                .font(.largeTitle)
                .foregroundColor(.white)
                .offset(x: 0, y: -6)
        }
    }
    
    @State var customConfig = StarRatingConfiguration(spacing: 8,
                                                      numberOfStars: 10,
                                                      stepType: .full,
                                                      minRating: 2,
                                                      borderWidth: 1,
                                                      borderColor: Color.Example.border,
                                                      emptyColor: Color.Example.border.opacity(0.15),
                                                      shadowRadius: 0,
                                                      fillColors: [Color].random,
                                                      starVertices: 6,
                                                      starWeight: 0.6)
    
    var body: some View {
        VStack {
            // Example of using the Star Shape
            bigStar
                   
            // Example of using StarRating with default configuration
            StarRating(initialRating: 3.7, onRatingChanged: { print($0) })
                .frame(width: 300, height: 50)
                .animation(.linear)
            
            // Example of using StarRating with custom configuration & with live updates
            StarRating(initialRating: 2.0, configuration: $customConfig) { newRating in
                customConfig.starVertices = Int(newRating)
                customConfig.fillColors = [Color].random
            }
            
            Spacer()
            
            // Example of using StarRating as display only
            StarRating(initialRating: 3.7)
                .frame(width: 300, height: 50)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
                .padding()
                .previewLayout(.sizeThatFits)
            
            ContentView()
                .padding()
                .environment(\.colorScheme, .dark)
                .background(Color(red: 0.188, green: 0.192, blue: 0.208, opacity: 1.000))
                .previewLayout(.sizeThatFits)
        }
    }
}
