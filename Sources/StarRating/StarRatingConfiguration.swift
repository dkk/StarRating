import SwiftUI

/// This class can be used to configure StarRating's style & behaviour
public class StarRatingConfiguration: ObservableObject {
    @Published public var spacing: CGFloat
    @Published public var numberOfStars: Int
    @Published public var stepType: StarRating.StepType
    @Published public var minRating: Double
    @Published public var borderWidth: CGFloat
    @Published public var borderColor: Color
    @Published public var emptyColor: Color
    @Published public var shadowRadius: CGFloat
    @Published public var shadowColor: Color
    @Published public var fillColors: [Color]
    @Published public var starVertices: Int
    @Published public var starWeight: CGFloat
    
    /// - Parameters:
    ///     - spacing: spacing between stars
    ///     - numberOfStars: number of stars (note that changing this value changes the max rating value)
    ///     - stepType: .full will allow full star ratings, .half will also allow half stars
    ///     - minRating: the minimal rating allowed
    ///     - borderWidth: the width of the border of the stars
    ///     - borderColor: the color of the border
    ///     - emptyColor: empty star color
    ///     - shadowRadius: the radius of the star border shadow
    ///     - shadowColor: the color of the star border shadow
    ///     - fillColors: the colors of the gradient used to fill the stars
    ///     - starVertices:  The numer of vertices of the star (only outer points are counted),
    ///         must be at least 2 to show something
    ///     - starWeight: Defines the position of the inner points. 0: inner points == center,
    ///         1: inner points are at the height of the outer points
    public init (
        spacing: CGFloat = 12,
        numberOfStars: Int = 5,
        stepType: StarRating.StepType = .half,
        minRating: Double = 0,
        borderWidth: CGFloat = 2,
        borderColor: Color = .white,
        emptyColor: Color = .clear,
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
        self.emptyColor = emptyColor
        self.shadowRadius = shadowRadius
        self.shadowColor = shadowColor
        self.fillColors = fillColors
        self.starVertices = starVertices
        self.starWeight = starWeight
        self.minRating = StarRating.normalizedRating(rating: minRating, numberOfStars: numberOfStars, stepType: stepType)
    }
}
