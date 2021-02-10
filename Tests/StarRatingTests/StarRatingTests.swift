import XCTest
@testable import StarRating

final class StarRatingTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(StarRating().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
