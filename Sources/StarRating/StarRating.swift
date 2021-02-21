import SwiftUI

/// A customizable star rating element It shows a star rating and handles user input.
public struct StarRating: View {
    /// clips the rating to the allowed interval and rounds it
    /// depending on the stepType
    public static func normalizedRating(rating: Double, minRating: Double, numberOfStars: Int, stepType: StepType) -> Double {
        let ratingInInterval = min(max(rating, minRating), Double(numberOfStars))
        switch stepType {
        case .half: return round(ratingInInterval * 2) / 2
        case .full: return round(ratingInInterval)
        case .exact: return ratingInInterval
        }
    }
    
    public enum StepType {
        case full, half, exact
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
        let normalizedRating = StarRating.normalizedRating(rating: initialRating,
                                                           minRating: configuration.wrappedValue.minRating,
                                                           numberOfStars: configuration.wrappedValue.numberOfStars,
                                                           stepType: configuration.wrappedValue.stepType)
        _rating = State(initialValue: normalizedRating)
    }
    
    private var starBorder: some View {
        Star(vertices: configuration.starVertices, weight: configuration.starWeight)
            .stroke(configuration.borderColor, lineWidth: configuration.borderWidth)
            .aspectRatio(contentMode: .fit)
    }
    
    private var starBackground: some View {
        Star(vertices: configuration.starVertices, weight: configuration.starWeight)
            .fill(configuration.emptyColor)
            .aspectRatio(contentMode: .fit)
    }
    
    private var starFilling: some View {
        return Star(vertices: configuration.starVertices,
                    weight: configuration.starWeight)
            .fill(LinearGradient(
                gradient: .init(colors: configuration.fillColors),
                startPoint: .init(x: 0, y: 0),
                endPoint: .init(x: 1, y: 1)
            ))
            .aspectRatio(contentMode: .fit)
    }
    
    private func updateRatingIfNeeded(width: CGFloat, marginSize: CGFloat, xLocation: CGFloat) {
        guard let onRatingChanged = onRatingChanged else { return }
        
        let widthWithoutMargin = width - marginSize * 2
        let numberOfSpaces = CGFloat(configuration.numberOfStars - 1)
        let starWidth = (widthWithoutMargin - configuration.spacing * numberOfSpaces) / CGFloat(configuration.numberOfStars)
        
        guard starWidth > 0 else { return }
        
        var newRating: CGFloat?
        var minLoc = marginSize
        var idx = 0
        repeat {
            let lowBound = CGFloat(idx)
            let loc = xLocation - minLoc
            if loc <= starWidth {
                let percentOfStar = max(loc, 0) / starWidth
                newRating = lowBound + percentOfStar
            } else {
                minLoc += starWidth + configuration.spacing
                idx += 1
                
                if idx >= configuration.numberOfStars {
                    newRating = CGFloat(configuration.numberOfStars)
                }
            }
        } while (newRating == nil)
        
        let normalizedRating = Self.normalizedRating(rating: Double(newRating!),
                                                     minRating: configuration.minRating,
                                                     numberOfStars: configuration.numberOfStars,
                                                     stepType: configuration.stepType)
        
        if normalizedRating != rating {
            rating = normalizedRating
            onRatingChanged(rating)
        }
    }
    
    private func ratingWidth(fullWidth: CGFloat, horizontalPadding: CGFloat) -> CGFloat {
        let widthWithoutMargin = fullWidth - horizontalPadding * 2
        let numberOfSpaces = CGFloat(configuration.numberOfStars - 1)
        let starWidth = (widthWithoutMargin - configuration.spacing * numberOfSpaces) / CGFloat(configuration.numberOfStars)
        return CGFloat(rating) * starWidth + floor(CGFloat(rating)) * configuration.spacing
    }
    
    public var body: some View {
        GeometryReader { geo in
            let horizontalPadding = geo.size.width / CGFloat(configuration.numberOfStars * 2)
            
            let maskWidth = ratingWidth(fullWidth:geo.size.width,
                                        horizontalPadding: horizontalPadding)
            
            let drag = DragGesture(minimumDistance: 0).onChanged { value in
                updateRatingIfNeeded(width: geo.size.width,
                                     marginSize: horizontalPadding,
                                     xLocation: value.location.x)
            }
            
            ZStack {
                HStack(spacing: configuration.spacing) {
                    ForEach((0 ..< configuration.numberOfStars), id: \.self) { index in
                        
                        starBorder
                            .shadow(color: configuration.shadowColor, radius: configuration.shadowRadius)
                            .background(starBackground)
                    }
                }
                
                HStack(spacing: configuration.spacing) {
                    ForEach((0 ..< configuration.numberOfStars), id: \.self) { index in
                        
                        starFilling
                            .mask(Rectangle().size(width: maskWidth, height: geo.size.height))
                            .overlay(starBorder)
                    }
                }
                .mask(Rectangle().size(width: maskWidth, height: geo.size.height))
            }
            .padding(.horizontal, horizontalPadding)
            .contentShape(Rectangle())
            .gesture(drag)
        }
    }
}

struct StarRating_Previews: PreviewProvider {
    static var previews: some View {
        StarRating(initialRating: 2.3)
    }
}
