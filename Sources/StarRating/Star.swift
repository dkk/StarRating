import SwiftUI

public struct Star: Shape {
    let vertices: Int
    let weight: CGFloat
    
    public init(vertices: Int = 5, weight: CGFloat = 0.45) {
        self.vertices = vertices
        self.weight = weight
    }
    
    public func path(in rect: CGRect) -> Path {
        guard vertices > 1 else { return Path() }
        
        var angle: CGFloat = .pi / -2
        
        // angle from a vertex to an inner point
        let sectionAngle: CGFloat = .pi / CGFloat(vertices)
        
        let innerPointMovement = CGVector(dx: rect.center.x,
                                          dy: rect.center.y).scale(by: weight)
        
        let startingPoint = CGPoint(x: 0, y: -rect.center.y)
        
        var path = Path()
        path.move(to: startingPoint) // set starting point
        
        var lowestPointY: CGFloat = 0
        
        for vertexIndex in 0 ..< vertices * 2 {
            let unitMovement = CGPoint(angle: angle)
            let point: CGPoint
            
            if vertexIndex % 2 == 0 {
                point = CGPoint(x: rect.center.x * unitMovement.x, y: rect.center.y * unitMovement.y)
            } else {
                point = CGPoint(x: unitMovement.x * innerPointMovement.dx, y: unitMovement.y * innerPointMovement.dy)
            }
            path.addLine(to: point)
            
            if point.y > lowestPointY {
                lowestPointY = point.y
            }
            
            angle += sectionAngle
        }
        path.closeSubpath()
        
        let unusedSpace = (rect.height / 2 - lowestPointY) / 2
        let transform = CGAffineTransform(translationX: rect.center.x, y: rect.center.y + unusedSpace)
        return path.applying(transform)
    }
}
