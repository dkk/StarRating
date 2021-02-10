import SwiftUI

extension CGPoint {
    // Creates a point from the components of the resulting unit vector
    init(angle: CGFloat) {
        self = CGPoint(x: cos(angle), y: sin(angle))
    }
}
