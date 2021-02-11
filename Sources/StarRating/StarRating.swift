import SwiftUI

/// A customizable star rating element It shows a star rating and handles user input.
public struct StarRating: View {
    public enum StepType {
        case full, half
    }
    
    private enum StarFilling {
        case empty, half, full
    }
    
    /// The configuration of the StarRating control.
    /// Allows you to customize style and behaviour
    @Binding public var configuration: StarRatingConfiguration
    
    /// The currently selected rating
    @State public var rating: Double
    
    /// Gets called when the user changes the rating by tapping or dragging
    private var onRatingChanged: ((Double) -> Void)?
    
    /// - Parameters:
    ///     - initialRating: The initial rating value
    ///     - configuration: The configuration of the StarRating control.
    ///                      Allows you to customize style and behaviour
    ///     - onRatingChanged: Gets called when the user changes the rating
    ///                        by tapping or dragging
    public init (
        initialRating: Double,
        configuration: Binding<StarRatingConfiguration> = .constant(StarRatingConfiguration()),
        onRatingChanged: ((Double) -> Void)? = nil
    ) {
        self.onRatingChanged = onRatingChanged
        
        _configuration = configuration        
        _rating = State(initialValue: initialRating)
    }
    
    private func starFilling(rating: Double) -> StarFilling {
        if rating <= 0 { return .empty }
        
        switch configuration.stepType {
        case .full:
            return rating >= 1 ? .full : .empty
        case .half:
            if rating < 0.5 { return .empty }
            if rating < 1 { return .half}
            return .full
        }
    }
    
    private func starBorder() -> some View {
        Star(vertices: configuration.starVertices, weight: configuration.starWeight)
            .stroke(configuration.borderColor, lineWidth: configuration.borderWidth)
            .aspectRatio(contentMode: .fit)
            .shadow(color: configuration.shadowColor, radius: configuration.shadowRadius)
    }
    
    private func filledStar(filling: StarFilling) -> some View {
        let trimStart: CGFloat
        switch filling {
        case .empty: trimStart = 1.0
        case .half: trimStart = 0.5
        case .full: trimStart = 0.0
        }
        
        return Star(vertices: configuration.starVertices, weight: configuration.starWeight)
            .trim(from: trimStart, to: 1.0)
            .fill(LinearGradient(
                gradient: .init(colors: configuration.fillColors),
                startPoint: .init(x: 0, y: 0),
                endPoint: .init(x: 1, y: 1)
            ))
            .aspectRatio(contentMode: .fit)
    }
    
    
    
    private static func halfAStar(width: CGFloat, stars: Int) -> CGFloat {
        width / CGFloat(stars * 2)
    }
    
    private func updateRatingIfNeeded(width: CGFloat, xLocation: CGFloat) {
        guard let onRatingChanged = onRatingChanged else { return }
        let halfAStar = Self.halfAStar(width: width, stars: configuration.numberOfStars)
        
        guard xLocation > (halfAStar * CGFloat(configuration.minRating) * 2) else {
            if rating != configuration.minRating {
                rating = configuration.minRating
                onRatingChanged(rating)
            }
            return
        }
        
        guard xLocation < width - halfAStar else {
            let maxRating = Double(configuration.numberOfStars)
            if rating != maxRating {
                rating = maxRating
                onRatingChanged(rating)
            }
            return
        }
        
        let newRating = Double(CGFloat(configuration.numberOfStars) * (xLocation - halfAStar) / (width - halfAStar * 2))
        
        let roundedNewRating: Double
        switch configuration.stepType{
        case .half: roundedNewRating = round(newRating * 2.0) / 2.0
        case.full: roundedNewRating = round(newRating)
        }
        
        if roundedNewRating != rating {
            rating = roundedNewRating
            onRatingChanged(rating)
        }
    }
    
    public var body: some View {
        GeometryReader { geo in
            let halfAStar = Self.halfAStar(width: geo.size.width, stars: configuration.numberOfStars)
            
            let drag = DragGesture(minimumDistance: 0).onChanged { value in
                updateRatingIfNeeded(width: geo.size.width, xLocation: value.location.x)
            }
            
            HStack(spacing: configuration.spacing) {
                ForEach((0 ..< configuration.numberOfStars), id: \.self) { index in
                    ZStack {
                        starBorder()
                        
                        filledStar(filling: starFilling(rating: rating - Double(index)))
                            .overlay(starBorder())
                    }
                }
            }
            .padding([.leading, .trailing], halfAStar)
            .gesture(drag)
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(initialRating: 2.3)
    }
}
