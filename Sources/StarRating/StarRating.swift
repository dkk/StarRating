import SwiftUI

public struct StarRating: View {
    public enum StepType {
        case full, half
    }
    
    private enum StarFilling {
        case empty, half, full
    }
    
    public var styling: StarRatingStyle
    
    @State public var rating: Double
    
    public init (
        rating: Double,
        styling: StarRatingStyle = StarRatingStyle()
    ) {
        self.styling = styling
        
        _rating = State(initialValue: rating)
    }
    
    private func starFilling(rating: Double) -> StarFilling {
        if rating <= 0 { return .empty }
        
        switch styling.stepType {
        case .full:
            return rating >= 1 ? .full : .empty
        case .half:
            if rating < 0.5 { return .empty }
            if rating < 1 { return .half}
            return .full
        }
    }
    
    private func starBorder() -> some View {
        Star(vertices: styling.starVertices, weight: styling.starWeight)
            .stroke(styling.borderColor, lineWidth: styling.borderWidth)
            .aspectRatio(contentMode: .fit)
            .shadow(color: styling.shadowColor, radius: styling.shadowRadius)
    }
    
    private func fiilledStar(filling: StarFilling) -> some View {
        let trimStart: CGFloat
        switch filling {
        case .empty: trimStart = 1.0
        case .half: trimStart = 0.5
        case .full: trimStart = 0.0
        }
        
        return Star(vertices: styling.starVertices, weight: styling.starWeight)
            .trim(from: trimStart, to: 1.0)
            .fill(LinearGradient(
                gradient: .init(colors: [styling.fillColor1, styling.fillColor2]),
                startPoint: .init(x: 0, y: 0),
                endPoint: .init(x: 1, y: 1)
            ))
            .aspectRatio(contentMode: .fit)
    }
    
    public var body: some View {
        HStack(spacing: styling.spacing) {
            ForEach((0 ..< styling.numberOfStars), id: \.self) { index in
                ZStack {
                    starBorder()
                    
                    fiilledStar(filling: starFilling(rating: rating - Double(index)))
                        .overlay(starBorder())
                }
            }
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(rating: 2.3)
    }
}
