import SwiftUI

public class StarRatingConfiguration: ObservableObject {
    @Published public var spacing: CGFloat
    @Published public var numberOfStars: Int
    @Published public var stepType: StarRating.StepType
    @Published public var minRating: Double
    @Published public var borderWidth: CGFloat
    @Published public var borderColor: Color
    @Published public var shadowRadius: CGFloat
    @Published public var shadowColor: Color
    @Published public var fillColors: [Color]
    @Published public var starVertices: Int
    @Published public var starWeight: CGFloat
    
    public init (
        spacing: CGFloat = 12,
        numberOfStars: Int = 5,
        stepType: StarRating.StepType = .half,
        minRating: Double = 0,
        borderWidth: CGFloat = 2,
        borderColor: Color = .white,
        shadowRadius: CGFloat = 4,
        shadowColor: Color = Color.StarRating.defaultShadow,
        fillColors: [Color] = [.yellow, .orange],
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
        self.fillColors = fillColors
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
