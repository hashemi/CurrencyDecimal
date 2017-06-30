extension Character {
    var isDigit: Bool {
        return self >= "0" && self <= "9"
    }
    
    var isMinusSign: Bool {
        return self == "-"
    }
    
    var isDecimalPoint: Bool {
        return self == "."
    }
}

struct CurrencyDecimal {
    let beforeDecimal: String
    let afterDecimal: String
    
    init?(string: String) {
        var current = string.startIndex
        
        @discardableResult func advance() -> Character {
            guard current < string.endIndex
                else { return "\0" }
            let cc = string[current]
            current = string.index(after: current)
            return cc
        }
        
        @discardableResult func peek() -> Character {
            let peekIdx = string.index(after: current)
            guard peekIdx < string.endIndex else { return "\0" }
            return string[peekIdx]
        }
        
        // first character can be minus sign
        if peek().isMinusSign { advance() }
        
        // as many digits as possible
        while peek().isDigit { advance() }
        
        // digits before decimal, incluing minus sign
        beforeDecimal = String(string[...current])
        
        // skip over decimal, if present
        if peek().isDecimalPoint { advance() }
        
        // as many digits as possible, after decimal sign
        let afterDecimalStartIdx = string.index(after: current)
        while peek().isDigit { advance() }
        
        afterDecimal = String(string[afterDecimalStartIdx...current])
        
        // if not at the end of the string now, failed to parse a decimal
        if peek() != "\0" {
            return nil
        }
    }
    
    var stringValue: String {
        return "\(beforeDecimal).\(afterDecimal)"
    }
}

