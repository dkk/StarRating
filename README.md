# StarRating

![Example](./example.png?raw=true) ![Example Dark](./example_dark.png?raw=true)

This is a customizable star rating control written specifically for SwiftUI. It shows a star rating and handles user input.
It also contains a star Shape with customizable number of vertices and weight.

## Installation
Requirements iOS 13+

### Swift Package Manager 
1. In Xcode, open your project and navigate to File → Swift Packages → Add Package Dependency.
2. Paste the repository URL (https://github.com/dkk/StarRating) and click Next.
3. For Rules, select version.
4. Click Finish.

### Swift Package
```swift
.package(url: "https://github.com/dkk/StarRating", .upToNextMajor(from: "1.2.0"))
```

## Usage

Import StarRating package to your view.

```swift
import StarRating
```

and you are ready to use `StarRating` or the `Shape` `Star` in you SwiftUI code.

### Use StarRating to display a rating
You can display a rating with the line:
```swift
// set the rating you want to display as initialRating
StarRating(initialRating: 3.7) 
```

### Use StarRating to get a rating from the user
To show a fully functional star rating that can handle user input, add the line:
```swift
// set the initialRating
// add a callback to do something with the new rating
StarRating(initialRating: 0, onRatingChanged: { print($0) })
```

### Configure StarRating
To configure the control, `StarRating` binds a `StarRatingConfiguration` object. This makes it easy to dynamically change the control's style and behaviour.

1. Create a `StarRatingConfiguration` object:
```swift
@State var customConfig = StarRatingConfiguration(minRating: 2, numberOfStars: 10)
```

2. Pass it when creating the instance of `StarRating` and update it later as needed:
```swift
StarRating(initialRating: 2.0, configuration: $customConfig) { newRating in
    customConfig.starVertices = Int(newRating)
}
```

Read the implementation of [StarRatingConfiguration](Sources/StarRating/StarRatingConfiguration.swift) to see what configuration posibilities are available at the moment.

### Use the Star Shape
Use `Star` the same way as you would use standard SwiftUI Shapes, such as `Rectangle`. `Star` allows to configure the number of vertices and the weight. Example usage:
```swift
Star(vertices: 5, weight: 0.45)
```

## License

StarRating is released under the [MIT License](LICENSE).
