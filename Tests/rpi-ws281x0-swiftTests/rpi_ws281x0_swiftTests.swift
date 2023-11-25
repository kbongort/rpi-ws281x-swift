import XCTest
@testable import rpi_ws281x0_swift

final class rpi_ws281x0_swiftTests: XCTestCase {
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(rpi_ws281x0_swift().text, "Hello, World!")
    }
}
