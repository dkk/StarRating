import SwiftUI

extension CGVector {
    func scale(by scalar: CGFloat) -> CGVector {
        CGVector(dx: dx * scalar, dy: dy * scalar)
    }
}
