import XCTest
@testable import CurrencyDecimal

class CurrencyDecimalTests: XCTestCase {
    func testNoDecimalPlaces() {
        XCTAssertEqual(CurrencyDecimal(string: "123")?.description, "123.000")
    }
    
    func testOneDecimalPlace() {
        XCTAssertEqual(CurrencyDecimal(string: "11.2")?.description, "11.200")
    }


    static var allTests = [
        ("testNoDecimalPlaces", testNoDecimalPlaces),
        ("testOneDecimalPlace", testOneDecimalPlace),
    ]
}
