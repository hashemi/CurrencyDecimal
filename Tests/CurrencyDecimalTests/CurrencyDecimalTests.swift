import XCTest
@testable import CurrencyDecimal

class CurrencyDecimalTests: XCTestCase {
    func testOneDecimalPlace() {
        XCTAssertEqual(CurrencyDecimal(string: "11.2")?.stringValue, "11.2")
    }


    static var allTests = [
        ("testOneDecimalPlace", testOneDecimalPlace),
    ]
}
