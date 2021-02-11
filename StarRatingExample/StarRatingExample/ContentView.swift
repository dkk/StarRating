import SwiftUI
import StarRating

extension Color {
    struct Example {
        static var border: Color {
            Color(.init { $0.userInterfaceStyle == .light ? .black : .white })
        }

    }
}

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    
    var shadowWhite: Double {
        colorScheme == .light ? 0 : 1
    }
    
    var bigStar: some View {
        ZStack {
            Star()
                .fill(LinearGradient(
                    gradient: .init(colors: [.pink, .blue]),
                    startPoint: .init(x: 0, y: 0),
                    endPoint: .init(x: 1, y: 1)
                ))
                .frame(width: 300, height: 300, alignment: .center)
                .overlay(Star().stroke(Color.white, lineWidth: 4))
                .shadow(
                    color: Color(white: shadowWhite, opacity: 0.33),
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
                                                      shadowRadius: 0,
                                                      fillColor1: .pink,
                                                      fillColor2: .blue,
                                                      starVertices: 6,
                                                      starWeight: 0.6)
    
    var body: some View {
        VStack {
            bigStar
                   
            // standard
            StarRating(rating: 3.7, onRatingChanged: { print($0) })
                .frame(width: 300, height: 50)
            
            // custom & with live update
            StarRating(rating: 3.7, configuration: $customConfig) { newRating in
                if newRating == 0 {
                    customConfig.starVertices = Int(newRating)
                } else {
                    customConfig.starVertices = Int(newRating)
                }
                
            }
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
