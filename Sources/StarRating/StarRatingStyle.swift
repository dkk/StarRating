import SwiftUI

public struct StarRatingStyle {
    public let spacing: CGFloat
    public let numberOfStars: Int
    public let stepType: StarRating.StepType
    public let borderWidth: CGFloat
    public let borderColor: Color
    public let shadowRadius: CGFloat
    public let shadowColor: Color
    public let fillColor1: Color
    public let fillColor2: Color
    public let starVertices: Int
    public let starWeight: CGFloat
    
    public init (
        spacing: CGFloat = 12,
        numberOfStars: Int = 5,
        stepType: StarRating.StepType = .half,
        borderWidth: CGFloat = 2,
        borderColor: Color = .white,
        shadowRadius: CGFloat = 4,
        shadowColor: Color = Color.StarRating.defaultShadow,
        fillColor1: Color = .yellow,
        fillColor2: Color = .orange,
        starVertices: Int = 5,
        starWeight: CGFloat = 0.45
    ) {
        self.spacing = spacing
        self.numberOfStars = numberOfStars
        self.stepType = stepType
        self.borderWidth = borderWidth
        self.borderColor = borderColor
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.fillColor1 = fillColor1
        self.fillColor2 = fillColor2
        self.starVertices = starVertices
        self.starWeight = starWeight
    }
}
