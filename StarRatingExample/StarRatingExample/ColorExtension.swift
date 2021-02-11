import SwiftUI

extension Color {
    struct Example {
        static var border: Color {
            Color(.init { $0.userInterfaceStyle == .light ? .black : .white })
        }
        
        static var shadow: Color {
            Color(.init { $0.userInterfaceStyle == .light ? UIColor.black.withAlphaComponent(0.33) : UIColor.white.withAlphaComponent(0.33) })
        }
    }
    
    static var random: Color {
        Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}

extension Array where Element == Color {
    static var random: [Color] {
        var colors = [Color]()
        for _ in (0 ..< Int.random(in: 1...6)) {
            colors += [Color.random]
        }
        return colors
    }
}

