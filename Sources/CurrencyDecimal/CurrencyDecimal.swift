extension Character {
    var isDigit: Bool {
        return self >= "0" && self <= "9"
    }
    
    var digitValue: Int? {
        let mapping: [Character: Int] = [
            "0": 0, "1": 1, "2": 2, "3": 3, "4": 4,
            "5": 5, "6": 6, "7": 7, "8": 8, "9": 9,
        ]
        return mapping[self]
    }
}

struct CurrencyDecimal {
    static let fixedDecimalPlaces = 3
    
    let value: Int
    
    init?(string: String) {
        enum State {
            case beforeDecimal
            case afterDecimal
        }
        
        var value: Int = 0
        var isNegative = false
        var current = string.startIndex
        var state: State = .beforeDecimal
        var decimalPlaces = 0
        
        while current < string.endIndex {
            let c = string[current]
            switch (state, c) {
            case (.beforeDecimal, "-") where current == string.startIndex:
                isNegative = true
            case (.beforeDecimal, _) where c.isDigit:
                value = (value * 10) + c.digitValue!
            case (.beforeDecimal, "."):
                state = .afterDecimal
            case (.afterDecimal, _) where c.isDigit:
                value = (value * 10) + c.digitValue!
                decimalPlaces += 1
            default:
                return nil
            }
            
            current = string.index(after: current)
        }
        
        
        if decimalPlaces > CurrencyDecimal.fixedDecimalPlaces {
            return nil
        }
        
        let decimalOffset = CurrencyDecimal.fixedDecimalPlaces - decimalPlaces
        value *= [0, 10, 100, 1000][decimalOffset]
        
        if isNegative { value *= -1 }
        
        self.value = value
    }
}

extension CurrencyDecimal: CustomStringConvertible {
    var description: String {
        let sign = value < 0 ? "-" : ""
        let absValue = abs(value)
        
        if absValue < 10 { return "\(sign)0.00\(value)" }
        if absValue < 100 { return "\(sign)0.0\(value)" }
        if absValue < 1000 { return "\(sign)0.\(value)" }
        
        let string = absValue.description
        
        let beforeDecimal = string.prefix(string.count - CurrencyDecimal.fixedDecimalPlaces)
        let afterDecimal = string.suffix(CurrencyDecimal.fixedDecimalPlaces)
        
        return "\(sign)\(beforeDecimal).\(afterDecimal)"
    }
}
