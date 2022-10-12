import XCTest
@testable import RXExts

final class RXExtsTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Bundle.main.rx.base, Bundle.main)
    }
}
