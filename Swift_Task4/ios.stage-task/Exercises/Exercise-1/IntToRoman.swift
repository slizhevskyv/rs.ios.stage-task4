import Foundation

enum RomanNumber: Int {
    case I = 1
    case V = 5
    case X = 10
    case L = 50
    case C = 100
    case D = 500
    case M = 1000
    
    var stringRepresentation: String {
        switch self {
        case .I:
            return "I"
        case .V:
            return "V"
        case .X:
            return "X"
        case .L:
            return "L"
        case .C:
            return "C"
        case .D:
            return "D"
        case .M:
            return "M"
        }
    }
}

enum RomanNumberCombinationException: String {
    case CM
    case CD
    case XC
    case XL
    case IX
    case IV
    
    var valueToSubtract: Int {
        switch self {
        case .CM:
            return getExceptionValue(base: .M, substract: .C)
        case .CD:
            return getExceptionValue(base: .D, substract: .C)
        case .XC:
            return getExceptionValue(base: .C, substract: .X)
        case .XL:
            return getExceptionValue(base: .L, substract: .X)
        case .IX:
            return getExceptionValue(base: .X, substract: .I)
        case .IV:
            return getExceptionValue(base: .V, substract: .I)
        }
    }
}

func getExceptionValue(base: RomanNumber, substract: RomanNumber) -> Int {
    base.rawValue - substract.rawValue
}

func toRomanRepresentation(number: Int) -> String {
    var tempNumber = number;
    var romanRepresentation = "";
    
    func commitResult(valueToSubtract: Int, romanRepresentationSymbol: String) {
        tempNumber -= valueToSubtract;
        romanRepresentation += romanRepresentationSymbol;
    }
    
    while (tempNumber != 0) {
        if (tempNumber >= RomanNumber.M.rawValue) {
            commitResult(valueToSubtract: RomanNumber.M.rawValue, romanRepresentationSymbol: RomanNumber.M.stringRepresentation);
        } else if (tempNumber >= RomanNumberCombinationException.CM.valueToSubtract) {
            commitResult(valueToSubtract: RomanNumberCombinationException.CM.valueToSubtract, romanRepresentationSymbol: RomanNumberCombinationException.CM.rawValue);
        } else if (tempNumber >= RomanNumber.D.rawValue) {
            commitResult(valueToSubtract: RomanNumber.D.rawValue, romanRepresentationSymbol: RomanNumber.D.stringRepresentation);
        } else if (tempNumber >= RomanNumberCombinationException.CD.valueToSubtract) {
            commitResult(valueToSubtract: RomanNumberCombinationException.CD.valueToSubtract, romanRepresentationSymbol: RomanNumberCombinationException.CD.rawValue);
        } else if (tempNumber >= RomanNumber.C.rawValue) {
            commitResult(valueToSubtract: RomanNumber.C.rawValue, romanRepresentationSymbol: RomanNumber.C.stringRepresentation);
        } else if (tempNumber >= RomanNumberCombinationException.XC.valueToSubtract) {
            commitResult(valueToSubtract: RomanNumberCombinationException.XC.valueToSubtract, romanRepresentationSymbol: RomanNumberCombinationException.XC.rawValue);
        } else if (tempNumber >= RomanNumber.L.rawValue) {
            commitResult(valueToSubtract: RomanNumber.L.rawValue, romanRepresentationSymbol: RomanNumber.L.stringRepresentation);
        } else if (tempNumber >= RomanNumberCombinationException.XL.valueToSubtract) {
            commitResult(valueToSubtract: RomanNumberCombinationException.XL.valueToSubtract, romanRepresentationSymbol: RomanNumberCombinationException.XL.rawValue);
        } else if (tempNumber >= RomanNumber.X.rawValue) {
            commitResult(valueToSubtract: RomanNumber.X.rawValue, romanRepresentationSymbol: RomanNumber.X.stringRepresentation);
        } else if (tempNumber >= RomanNumberCombinationException.IX.valueToSubtract) {
            commitResult(valueToSubtract: RomanNumberCombinationException.IX.valueToSubtract, romanRepresentationSymbol: RomanNumberCombinationException.IX.rawValue);
        } else if (tempNumber >= RomanNumber.V.rawValue) {
            commitResult(valueToSubtract: RomanNumber.V.rawValue, romanRepresentationSymbol: RomanNumber.V.stringRepresentation);
        } else if (tempNumber >= RomanNumberCombinationException.IV.valueToSubtract) {
            commitResult(valueToSubtract: RomanNumberCombinationException.IV.valueToSubtract, romanRepresentationSymbol: RomanNumberCombinationException.IV.rawValue);
        } else {
            commitResult(valueToSubtract: RomanNumber.I.rawValue, romanRepresentationSymbol: RomanNumber.I.stringRepresentation)
        }
    }
    
    return romanRepresentation;
}

public extension Int {

    var roman: String? {
        if (self <= 0) {
            return nil;
        }

        return toRomanRepresentation(number: self);
    }
}
