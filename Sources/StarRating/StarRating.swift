import SwiftUI

public struct StarRating: View {
    public enum StepType {
        case full, half
    }
    
    private enum StarFilling {
        case empty, half, full
    }
    
    @Binding public var configuration: StarRatingConfiguration
    @State public var rating: Double
    
    private var onRatingChanged: ((Double) -> Void)?
    
    public init (
        rating: Double,
        configuration: Binding<StarRatingConfiguration> = .constant(StarRatingConfiguration()),
        onRatingChanged: ((Double) -> Void)? = nil
    ) {
        self.onRatingChanged = onRatingChanged
        
        _configuration = configuration        
        _rating = State(initialValue: rating)
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
    
    public var body: some View {
        GeometryReader { geo in
            let halfAStar = Self.halfAStar(width: geo.size.width, stars: configuration.numberOfStars)
            
            let drag = DragGesture(minimumDistance: 0).onChanged { value in
                guard let onRatingChanged = onRatingChanged else { return }
                
                guard value.location.x > (halfAStar * CGFloat(configuration.minRating) * 2) else {
                    if rating != configuration.minRating {
                        rating = configuration.minRating
                        onRatingChanged(rating)
                    }
                    return
                }
                
                guard value.location.x < geo.size.width - halfAStar else {
                    let maxRating = Double(configuration.numberOfStars)
                    if rating != maxRating {
                        rating = maxRating
                        onRatingChanged(rating)
                    }
                    
                    return
                }
                
                let newRating = Double(CGFloat(configuration.numberOfStars) * (value.location.x - halfAStar) / (geo.size.width - halfAStar * 2))
                
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
        StarRating(rating: 2.3)
    }
}
