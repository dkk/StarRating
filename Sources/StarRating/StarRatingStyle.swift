import SwiftUI

public struct StarRatingConfiguration {
    public let spacing: CGFloat
    public let numberOfStars: Int
    public let stepType: StarRating.StepType
    public let minRating: Double
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
        minRating: Double = 0,
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
        
        // allowed `minRating` values depend on `stepType` and `numberOfStars`. `minRating`
        // must be within [0, numberOfStars]. If `stepType == .half` it mult be multiple of 0.5.
        // If `stepType == .full` it mult be multiple of 1.
        let minRatingInInterval = min(max(minRating, 0), Double(numberOfStars))
        switch stepType {
        case .half: self.minRating = floor(minRatingInInterval * 2) / 2
        case .full: self.minRating = floor(minRatingInInterval)
        }
    }
}
