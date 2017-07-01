import XCTest
@testable import CurrencyDecimal

class CurrencyDecimalTests: XCTestCase {
    func testNoDecimalPlaces() {
        XCTAssertEqual(CurrencyDecimal(string: "123")?.description, "123.000")
    }
    
    func testOneDecimalPlace() {
        XCTAssertEqual(CurrencyDecimal(string: "11.2")?.description, "11.200")
    }
    
    func testMultipleDecimals() {
        XCTAssertEqual(CurrencyDecimal(string: "1..1")?.description, nil)
    }
    
    func testNegativeNumber() {
        XCTAssertEqual(CurrencyDecimal(string: "-1")?.description, "-1.000")
    }
    
    func testLiteralInteger() {
        let cd: CurrencyDecimal = 11
        XCTAssertEqual(cd.description, "11.000")
    }
    
    func testAdd() {
        let first = CurrencyDecimal(string: "59.99")!
        let second = CurrencyDecimal(string: "4.99")!
        
        XCTAssertEqual(first + second, CurrencyDecimal(string: "64.98")!)
    }
}
