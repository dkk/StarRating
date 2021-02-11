import SwiftUI

public extension Color {
    struct StarRating {
        private static let defaultLightShadow = UIColor(white: 0, alpha: 0.33)
        private static let defaultDarkShadow = UIColor(white: 1, alpha: 0.33)
        
        /// The color of the default star border shadow
        static public var defaultShadow: Color {
            Color(.init { $0.userInterfaceStyle == .light ? Self.defaultLightShadow : Self.defaultDarkShadow })
        }
    }
}
